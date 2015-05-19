require 'mustache'
require 'tic_tac_toe/view/board'

module TicTacToe
  module View

    class Game < Mustache
      attr_reader :game, :x_mark, :o_mark

      def self.render(game)
        if game
          self.new(game).render
        else
          "Shit, no game passed."
        end
      end

      def initialize(game)
        @game = game
        @x_mark = TicTacToe::Game::X
        @o_mark = TicTacToe::Game::O
      end

      def current_mark
        case game.current_mark
        when x_mark
          "ex"
        when o_mark
          "oh"
        end
      end

      def x_current
        game.current_mark == x_mark
      end

      def o_current
        game.current_mark == o_mark
      end

      def board
        TicTacToe::View::Board.new(game.board).render
      end

      def json_board
        {:current_mark => game.current_mark.to_s,
         :marks => game.board.map { |m| m.to_s }.to_a}.to_json
      end
    end

  end
end
