require 'mustache'

module TicTacToe
  module View

    class Board < Mustache
      attr_reader :board

      def initialize(board)
        @board = board
      end

      def positions
        board.map.with_index do |mark, index|
          {:mark => mark.to_s,
           :index => index,
           :beginrow => is_row_start?(index),
           :endrow =>   is_row_end?(index)}
        end
      end

      def is_row_start?(index)
        (index % 3) == 0
      end

      def is_row_end?(index)
        (index % 3) == 2
      end
    end

  end
end
