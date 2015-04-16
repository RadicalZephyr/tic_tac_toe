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

    def get_move
      got_input = false
      while not got_input
        begin
          str = @console.gets
          move = Integer(str)
          got_input = true
        rescue ArgumentError
        end
      end

      move
    end

    def do_turn
      moved = false
      while not moved
        move = get_move
        if @board.legal?(move)
          @board.move(@to_play, move)
          moved = true
        end
      end

      @to_play = NEXT_PLAYER[@to_play]
    end
  end

end
