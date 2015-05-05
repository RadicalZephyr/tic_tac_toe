require 'mustache'
require 'tic_tac_toe/views/board'

module TicTacToe
  module Views

    class Game < Mustache
      attr_reader :game, :x_mark, :o_mark

      self.template_path = File.dirname(__FILE__)

      def initialize(game)
        @game = game
        @x_mark = TicTacToe::Game::X
        @o_mark = TicTacToe::Game::O
      end

      def post_url
        # TODO: this
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
        TicTacToe::Views::Board.new(game.board).render
      end
    end

  end
end
