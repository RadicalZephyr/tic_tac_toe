module TicTacToe
  class Game
    attr_reader :to_play

    def initialize(display, board)
      @display, @board = display, board
      @to_play = "X"
    end

    def start
      @display.printf "Welcome to Tic Tac Toe"
    end

    def do_turn
      str = @display.gets
      @board.move(@to_play, 0)
      @to_play = "O"
    end
  end

end
