require 'json'

require 'rack_tac_toe'
require 'tic_tac_toe/core/player'

module TicTacToe
  module Web

    class RackShell
      attr_accessor :current_move

      def self.new_shell
        router = TicTacToe::Web::Router.new
        shell = RackShell.new(router)

        router.add_route("/", :GET) do |_|
          TicTacToe::Web::View::Home.render(nil)
        end

        router.add_route("/new-game", :POST) do |env|
          req = Rack::Request.new(env)
          game = TicTacToe::Core::Game.new_game
          game.set_players(*shell.get_players(req))
          req.session[:game] = game

          TicTacToe::Web::View::Game.render(game)
        end

        router.add_route("/make-move", :POST) do |env|
          req = Rack::Request.new(env)
          shell.current_move= req["move"]
          game = req.session[:game]

          if game
            shell.do_game_turn(game)
          end

          shell.render_game(game)
        end

        return shell
      end

      def initialize(router)
        @router = router

        @will_block = true
        @can_retry  = false
      end
      include TicTacToe::Core::Player

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

      def do_game_turn(game)
        game.next_turn
      end

      def render_game(game)
        if game && !game.finished?
          TicTacToe::Web::View::Game.render(game)
        elsif game && game.finished?
          TicTacToe::Web::View::FinishedGame.render(game)
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
          return TicTacToe::Core::Player::Random.new(Random.new)
        when "a", "ai"
          return TicTacToe::Core::Player::Minimax.new
        end
      end

    end
  end
end
