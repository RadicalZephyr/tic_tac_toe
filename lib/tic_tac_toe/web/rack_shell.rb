require 'json'

require 'rack_tac_toe'

module TicTacToe
  module Web

    class RackShell
      attr_accessor :req

      def self.new_shell
        router = TicTacToe::Web::Router.new
        player = TicTacToe::Player::Human.new
        shell = RackShell.new(router, player)
        player.set_shell(shell)

        router.add_route("/", :GET) do |_|
          TicTacToe::View::Home.render(nil)
        end

        router.add_route("/new-game", :POST) do |env|
          req = Rack::Request.new(env)
          game = TicTacToe::Core::Game.new_game
          game.set_players(*shell.get_players(req))
          req.session[:game] = game

          TicTacToe::View::Game.render(game)
        end

        router.add_route("/make-move", :POST) do |env|
          shell.req= Rack::Request.new(env)
          game = shell.req.session[:game]
          if game
            moved = false
            while not moved
              begin
                game.next_turn
                moved = true
              rescue ArgumentError
              end
            end
          end
          shell.req= nil

          shell.render_game(game)
        end

        return shell
      end

      def initialize(router, player)
        @router, @player = router, player
      end

      def get_move
        Integer(req["move"]) unless @req.nil?
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
          TicTacToe::View::Game.render(game)
        elsif game && game.finished?
          TicTacToe::View::FinishedGame.render(game)
        else
          "No game was found for this session."
        end
      end

      private
      def get_player(type)
        case type
        when "h", "human"
          return @player
        when "r", "random"
          return TicTacToe::Player::Random.new(Random.new)
        when "a", "ai"
          return TicTacToe::Player::Minimax.new
        end
      end

    end
  end
end
