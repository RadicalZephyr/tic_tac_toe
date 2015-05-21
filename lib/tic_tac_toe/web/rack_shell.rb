require 'json'

require 'tic_tac_toe'
require 'tic_tac_toe/views'

module TicTacToe
  module Web

    class RackShell
      attr_accessor :req

      def self.new_shell
        router, player = TicTacToe::Router.new, TicTacToe::Human.new
        shell = RackShell.new(router, player)

        router.add_route("/", :GET, TicTacToe::View::Home) { |_| nil }
        router.add_route("/new-game", :POST, TicTacToe::View::Game) do |env|
          req = Rack::Request.new(env)
          game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
          game.set_players(*shell.get_players(req))
          req.session[:game] = game

          game
        end

        router.add_route("/make-move", :POST, TicTacToe::View::Game) do |env|
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
          game
        end

        player.set_shell(shell)

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

      private
      def get_player(type)
        case type
        when "h", "human"
          return @player
        when "r", "random"
          return TicTacToe::AI::Random.new(Random.new)
        when "a", "ai"
          return TicTacToe::AI::Minimax.new
        end
      end

    end
  end
end
