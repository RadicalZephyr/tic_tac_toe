require "tic_tac_toe/version"

module TicTacToe

  class Game

    def initialize display
    end

    def start
    end

  end

  class Board

    def initialize
      @_marks = Array.new(9, " ")
    end

    def pos index
      @_marks[index]
    end

    def move index, mark
      @_marks[index] = mark
    end

    def won
      @_marks[0]
    end

  end

end
