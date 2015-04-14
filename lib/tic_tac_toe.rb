require "tic_tac_toe/version"

module TicTacToe
  class Game
    def start
    end
  end
  # Your code goes here...
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

  end

end
