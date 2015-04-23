module TicTacToe
  class Game
    attr_accessor :current_mark, :board

    NEXT_PLAYER = {"X" => "O",
                   "O" => "X"}

    def initialize(board)
      @board = board
      @current_mark = "X"
    end

    def swap_mark
      @current_mark = NEXT_PLAYER[current_mark]
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
