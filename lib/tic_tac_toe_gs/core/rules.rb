module TicTacToeGS
  module Core
    module Rules

      def self.all_marks_same?(marks)
        marks.all? { |m| m == marks[0] }
      end

      def self.winning_marks?(marks)
        marks[0] if all_marks_same?(marks) && !(marks[0].blank?)
      end

      def self.who_won?(board)
        board.attack_sets.map { |marks| winning_marks?(marks) }.compact.first
      end


      def self.draw?(board)
        who_won?(board) == nil and board.full? ? true : false
      end

      def self.finished?(board)
        (who_won?(board) or draw?(board)) ? true : false
      end

    end
  end
end
