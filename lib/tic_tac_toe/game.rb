module TicTacToe
  class Game
    attr_reader :to_play

    NEXT_PLAYER = {"X" => "O",
                   "O" => "X"}

    def initialize(console, board)
      @console, @board = console, board
      @to_play = "X"
    end

    def start
      @console.printf "Welcome to Tic Tac Toe"
    end

    def do_turn
      str = @console.gets
      move = Integer(str)

      if @board.legal?(move)
        @board.move(@to_play, move)
      end

      @to_play = NEXT_PLAYER[@to_play]
    end
  end

end
