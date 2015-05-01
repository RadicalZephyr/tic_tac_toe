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

      def get_wins_from_attacks(attacks, mark)
        get_indices_for(attacks) { |imarks| mark_can_win?(imarks, mark) }
      end

      def get_wins(node, mark)
        attacks = node.indexed_attack_sets
        get_wins_from_attacks(attacks, mark)
      end

      def score_node(node, mark)
        winner = TicTacToe::Rules.who_won?(node)
        if winner == @my_mark
          10
        elsif winner == @other_mark
          -10
        elsif TicTacToe::Rules.draw?(node)
          0
        else
          win_count = get_wins(node, @my_mark).uniq.count
          block_count = get_wins(node, @other_mark).uniq.count

          win_count - block_count
        end
      end

      def negamax(marks, node, depth, alpha, beta, color)
        if depth == 0 or TicTacToe::Rules.finished?(node)
          score = score_node(node, marks[color])
          pos = get_wins(node, marks[color]).first || -1
          return [pos, color * score * [1, depth].max]
        end

        best = [-1, -1000]
        node.empty_spaces.each do |index|
          next_child = node.speculative_move(marks[color], index)
          _, score = negamax(marks, next_child,
                             depth - 1, -beta, -alpha, -color)
          val = -score # Invert the returned score
          best = [best, [index, val]].max_by { |i, s| s }
          alpha = [alpha, val].max
          if alpha >= beta
            break
          end
        end
        return best
      end

      def get_move(board)
        marks = {1 => @my_mark, -1 => @other_mark}
        negamax(marks, board, 4, -1000, 1000, 1).first
      end

    end

  end
end
