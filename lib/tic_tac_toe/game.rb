module TicTacToe
  class Game
    attr_accessor :current_mark, :board

    NEXT_PLAYER = {"X" => "O",
                   "O" => "X"}

    def initialize(board)
      @board = board
      reset
    end

    def reset
      @current_mark = "X"
      board.reset
    end

    def swap_mark
      @current_mark = NEXT_PLAYER[current_mark]
    end

    def try_move(index:)
      if board.legal?(index)
        board.move(current_mark, index)
        swap_mark
        true
      else
        false
      end
    end

    def finished?
      TicTacToe::Rules.finished?(board)
    end

    def who_won?
      TicTacToe::Rules.who_won?(board)
    end

  end
end
