module TicTacToe
  module AI

    class Minimax

      def initialize(my_mark)
        @my_mark = my_mark
      end

      def count_marks(marks)
        marks.each_with_object(Hash.new(0)) { |mark, counts| counts[mark] += 1 }
      end

      def has_my_marks(imarks:, count:)
        counts = count_marks(imarks.map { |imark| imark.mark })
        counts[@my_mark] == count && counts[" "] == 1
      end

      def i_can_win?(imarks)
        has_my_marks(imarks: imarks, count: 2)
      end

      def they_can_win?(imarks)
        has_my_marks(imarks: imarks, count: 0)
      end

      def empty_space(imarks)
        imarks.select { |imark| imark.mark == " " }.map { |imark| imark.index }
      end

      def score(node)
        get_wins(node.indexed_attack_sets).count
      end

      def find_forks(board)
        scores = board.empty_spaces.map do |index|
          node = board.speculative_move("X", index)
          [index, score(node)]
        end

        scores.max_by { |i, s| s }.first
      end

      def get_wins(attacks)
        attacks.map { |imarks| empty_space(imarks) if i_can_win?(imarks)  }.flatten.compact
      end

      def get_blocks(attacks)
        attacks.map { |imarks| empty_space(imarks) if they_can_win?(imarks)  }.flatten.compact
      end

      def get_move(board)
        attacks = board.indexed_attack_sets
        win   = get_wins(attacks).first
        block = get_blocks(attacks).first

        win or block or find_forks(board)
      end

    end

  end
end
