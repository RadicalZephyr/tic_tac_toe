module TicTacToe
  module AI

    class Minimax

      def initialize(my_mark, other_mark)
        @my_mark, @other_mark = my_mark, other_mark
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

      def score_node(node)
        winner = TicTacToe::Rules.who_won?(node)
        if winner == @my_mark
          1
        elsif winner == @other_mark
          -1
        elsif TicTacToe::Rules.draw?(node)
          0
        end
      end

      def negamax(marks, node, depth, alpha, beta, color)
        if depth == 0 or TicTacToe::Rules.finished?(node)
          return [-1, color * depth * score_node(node)]
        end

        node.empty_spaces.map do |index|
          next_child = node.speculative_move(marks[color], index)
          _, score = negamax(marks, next_child, depth - 1, -beta, -alpha, -color)
          [index, -score]
        end.max_by { |i, s| s }
      end

      def get_move(board)
        negamax({1 => @my_mark, -1 => @other_mark}, board, 10, -100, 100, 1).first
      end

    end

  end
end
