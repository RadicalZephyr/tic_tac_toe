module TicTacToe
  class Game
    attr_accessor :current_mark, :board

    def initialize(board)
      @board = board
      @current_mark = "X"
    end

  end
end
