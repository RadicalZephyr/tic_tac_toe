module TicTacToe
  module Rules

    def Rules.all_marks_same?(marks)
      marks.all? { |m| m == marks[0] }
    end

    def Rules.winning_marks?(marks)
      marks[0] if all_marks_same?(marks) and marks[0] != " "
    end

    def Rules.who_won?(board)
      board.attack_sets.map { |marks| winning_marks?(marks) }.find(&:itself)
    end

    def Rules.draw?(board)
      who_won?(board) == nil and board.full? ? true : false
    end

    def Rules.finished?(board)
      (who_won?(board) or draw?(board)) ? true : false
    end

  end
end
