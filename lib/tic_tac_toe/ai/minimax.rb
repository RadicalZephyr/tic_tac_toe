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

      def has_fork?(node, mark)
        get_wins(node, mark).uniq.count > 1
      end

      def has_win?(node, mark)
        get_wins(node, mark).uniq.count == 1
      end

      def get_win(node, mark)
        get_wins(node, mark).first
      end

      def will_win?(node, mark)
        mark if has_win?(node, mark)
      end

      def whose_fork?(node)
        if has_fork?(node, @my_mark)
          @my_mark
        elsif has_fork?(node, @other_mark)
          @other_mark
        end
      end

      def find_winner(node, mark)
        TicTacToe::Rules.who_won?(node) || will_win?(node, mark) || whose_fork?(node)
      end

      def score_node(node, mark)
        winner = find_winner(node, mark)
        if winner == @my_mark
          10
        elsif winner == @other_mark
          -10
        elsif TicTacToe::Rules.draw?(node)
          0
        end
      end

      def should_stop?(node, mark)
        TicTacToe::Rules.finished?(node) or has_win?(node, mark) or whose_fork?(node)
      end

      def negamax(marks, node, depth, alpha, beta, color)
        if depth == 0 or should_stop?(node, marks[color])
          score = score_node(node, marks[color])
          pos = get_win(node, marks[color]) || -1
          return [pos, color * depth * score]
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
