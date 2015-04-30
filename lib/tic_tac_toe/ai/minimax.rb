module TicTacToe
  module AI

    class Minimax

      def initialize(my_mark, other_mark)
        @my_mark, @other_mark = my_mark, other_mark
      end

      def count_marks(marks)
        marks.each_with_object(Hash.new(0)) { |mark, counts| counts[mark] += 1 }
      end

      def mark_can_win?(imarks, mark)
        counts = count_marks(imarks.map { |imark| imark.mark })
        counts[mark] == 2 && counts[" "] == 1
      end

      def empty_space(imarks)
        imarks.select { |imark| imark.mark == " " }.map { |imark| imark.index }
      end

      def get_indices_for(attacks)
        attacks.map { |imarks| empty_space(imarks) if yield(imarks)  }.flatten.compact
      end

      def get_wins(attacks, mark)
        get_indices_for(attacks) { |imarks| mark_can_win?(imarks, mark) }
      end

      def get_blocks(attacks)
        get_indices_for(attacks) { |imarks| mark_can_win?(imarks, @other_mark) }
      end

      def has_fork?(node, mark)
        attacks = node.indexed_attack_sets
        get_wins(attacks, mark).uniq.count > 1
      end

      def score_node(node)
        winner = TicTacToe::Rules.who_won?(node)
        if winner == @my_mark
          10
        elsif winner == @other_mark
          -10
        elsif TicTacToe::Rules.draw?(node)
          0
        end
      end

      def negamax(marks, node, depth, alpha, beta, color)
        if depth == 0 or TicTacToe::Rules.finished?(node)
          return [-1, color * depth * score_node(node)]
        end

        best = [-1, -1000]
        node.empty_spaces.each do |index|
          next_child = node.speculative_move(marks[color], index)
          _, score = negamax(marks, next_child, depth - 1, -beta, -alpha, -color)
          val = -score # Invert the returned score as in regular negamax
          best = [best, [index, val]].max_by { |i, s| s }
          alpha = [alpha, val].max
          if alpha >= beta
            break
          end
        end
        return best
      end

      def get_move(board)
        negamax({1 => @my_mark, -1 => @other_mark}, board, 10, -1000, 1000, 1).first
      end

    end

  end
end
