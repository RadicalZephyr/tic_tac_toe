module TicTacToe
  module AI

    class Minimax

      def initialize(my_mark)
        @my_mark = my_mark
      end

      def count_marks(marks)
        marks.each_with_object(Hash.new(0)) { |mark, counts| counts[mark] += 1 }
      end

      def i_can_win?(imarks)
        counts = count_marks(imarks.map { |imark| imark[1] })
        counts[@my_mark] == 2 && counts[" "] == 1
      end

      def empty_space(imarks)
        imarks.select { |imark| imark[1] == " " }.map { |imark| imark[0] }
      end

      def get_move(board)
        attacks = board.indexed_attack_sets
        attacks.map { |imarks| empty_space(imarks) if i_can_win?(imarks)  }.flatten.compact.first
      end

    end

  end
end
