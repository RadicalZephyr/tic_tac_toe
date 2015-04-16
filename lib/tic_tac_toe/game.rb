module TicTacToe
  class Game
    attr_reader :to_play

    NEXT_PLAYER = {"X" => "O",
                   "O" => "X"}

    def initialize(console, board)
      @console, @board = console, board
      @to_play = "X"
    end

    def get_move
      got_input = false
      while not got_input
        @console.print "Enter your move [0-8]: "
        @console.flush
        str = @console.gets.chop
        begin
          move = Integer(str)
          got_input = true if move.between?(0,8)
        rescue ArgumentError
          @console.puts "Sorry, I didn't understand your move."
          @console.puts "Please try again."
        end
      end

      move
    end

    def do_turn
      @console.puts "\nIt is the #{@to_play}'s move.'"
      @console.puts @board.board_to_string
      @console.puts
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

    def game_loop
      @console.puts "Welcome to Tic Tac Toe!"
      while not @board.finished?
        do_turn
      end
    end
  end

end
