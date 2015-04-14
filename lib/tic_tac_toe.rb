require "tic_tac_toe/version"

module TicTacToe

  class Game

    def initialize display
    end

    def start
    end

  end

  class Board
    @@win_places = [[0, 1, 2],
                    [3, 4, 5],
                    [6, 7, 8],
                    [0, 3, 6],
                    [1, 4, 7],
                    [2, 5, 8],
                    [0, 4, 8],
                    [2, 4, 6]]

    def self.win_places
      @@win_places
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

    def who_won?
      @@win_places.map do |places|
        marks = places.map { |n| @_marks.at n }
        marks[0] if marks.all? { |m| m == marks[0] } and marks[0] != " "
      end.find(&:itself)
    end

    def draw?
      (who_won? == nil) and @_marks.none? { |m| m == " " } ? true : false
    end

  end

end
