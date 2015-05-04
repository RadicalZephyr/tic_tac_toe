require 'tic_tac_toe/mark'

module TicTacToe
  class Game
    attr_accessor :current_mark, :board

    X = TicTacToe::Mark.new("X")
    O = TicTacToe::Mark.new("O")

    NEXT_PLAYER = {X => O,
                   O => X}

    def self.make_new_game(board)
      game = TicTacToe::Game.new(board)
      game.reset
    end

    def initialize(board)
      @board = board
    end

    def reset
      @current_mark = X
      board.reset
      return self
    end

    def swap_mark
      @current_mark = NEXT_PLAYER[current_mark]
    end

    def move(index:)
      raise ArgumentError unless board.legal?(index)
      board.move(current_mark, index)
      swap_mark
    end

    def finished?
      TicTacToe::Rules.finished?(board)
    end

    def who_won?
      TicTacToe::Rules.who_won?(board)
    end

  end
end
