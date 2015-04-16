module TicTacToe

  class Board
    WIN_PLACES = [[0, 1, 2],
                  [3, 4, 5],
                  [6, 7, 8],
                  [0, 3, 6],
                  [1, 4, 7],
                  [2, 5, 8],
                  [0, 4, 8],
                  [2, 4, 6]]

    def self.win_places
      WIN_PLACES
    end

    def initialize
      @_marks = Array.new(9, " ")
    end

    def pos index
      @_marks[index]
    end

    def move index, mark
      @_marks[index] = mark
    end

    def legal? index
      false
    end

    def all_marks_same? marks
      marks.all? { |m| m == marks[0] }
    end

    def get_board_marks
      WIN_PLACES.map { |places| places.map { |n| @_marks.at n }}
    end

    def winning_marks? marks
      marks[0] if all_marks_same? marks and marks[0] != " "
    end

    def who_won?
      board_marks = get_board_marks
      board_marks.map { |marks| winning_marks? marks }.find(&:itself)
    end

    def draw?
      who_won? == nil and @_marks.none? { |m| m == " " } ? true : false
    end

    def finished?
      (who_won? or draw?) ? true : false
    end
  end

end
