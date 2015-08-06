require 'json'

require 'rack_tac_toe'
require 'tic_tac_toe_gs/core/player'

module TicTacToeGS
  module Web

    class RackShell < TicTacToeGS::Core::Player
      attr_accessor :current_move

      def self.new_shell
        router = TicTacToeGS::Web::Router.new
        shell = RackShell.new(router)

        router.add_route("/", :GET) do |_|
          TicTacToeGS::Web::Views::Home.render(nil)
        end

        router.add_route("/new-game", :POST) do |env|
          req = Rack::Request.new(env)
          game = TicTacToeGS::Core::Game.new_game
          game.set_players(*shell.get_players(req))
          game.do_nonblocking_turns
          req.session[:game] = game

          shell.render_game(game)
        end

        router.add_route("/make-move", :POST) do |env|
          req = Rack::Request.new(env)
          shell.current_move= req["move"]
          game = req.session[:game]

          game.do_nonblocking_turns unless game.nil?

          shell.render_game(game)
        end

        router.add_route("/api/new-game", :POST) do |env|
          req = Rack::Request.new(env)
          game = TicTacToeGS::Core::Game.new_game
          game.set_players(*shell.get_players(req))
          game.do_nonblocking_turns
          req.session[:game] = game

          ""
        end

        router.add_route("/api/make-move", :POST) do |env|
          req = Rack::Request.new(env)
          shell.current_move= req["move"]
          game = req.session[:game]

          game.do_nonblocking_turns unless game.nil?

          ""
        end

        router.add_route("/api/board", :GET) do |env|
          req = Rack::Request.new(env)
          game = req.session[:game]

          {:current_mark => game.current_mark.to_s,
           :marks => game.board.map { |m| m.to_s }.to_a}.to_json
        end

        return shell
      end

      def initialize(router)
        @router = router

        @can_retry  = false
      end

      def will_block?
        current_move.nil?
      end

      def get_move(_)
        unless current_move.nil?
          move = current_move
          @current_move = nil
          Integer(move)
        end
      end

      def set_marks(_, _)
      end

      def call(env)
        @router.match(env)
      end

      def get_players(req)
        [get_player(req["player1"]),
         get_player(req["player2"])]
      end

      def render_game(game)
        if game && !game.finished?
          TicTacToeGS::Web::Views::Game.render(game)
        elsif game && game.finished?
          TicTacToeGS::Web::Views::FinishedGame.render(game)
        else
          "No game was found for this session."
        end
      end

      private
      def get_player(type)
        case type
        when "h", "human"
          return self
        when "r", "random"
          return TicTacToeGS::Core::Players::Random.new(Random.new)
        when "a", "ai"
          return TicTacToeGS::Core::Players::Minimax.new
        end
      end

    end
  end
end
