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

    def move(index, mark)
      @_marks[index] = mark
    end

    def all_marks_same? marks
      marks.all? { |m| m == marks[0] }
    end

    def who_won?
      WIN_PLACES.map { |places|
        marks = places.map { |n| @_marks.at n }
        marks[0] if all_marks_same? marks and marks[0] != " "
      }.find(&:itself)
    end

    def draw?
      (who_won? == nil) and @_marks.none? { |m| m == " " } ? true : false
    end

  end

end
