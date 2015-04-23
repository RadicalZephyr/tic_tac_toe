module TicTacToe
  class Game
    attr_accessor :current_mark, :board

    def initialize(board)
      @board = board
      @current_mark = "X"
    end

    def try_move(index:)
      if board.legal?(index)
        board.move(current_mark, index)
        true
      else
        false
      end
    end

  end
end
