module TicTacToe
  class Game
    attr_reader :current_mark

    NEXT_PLAYER = {"X" => "O",
                   "O" => "X"}

    def initialize(console, board)
      @console, @board = console, board
      @current_mark = "X"
    end

    def prompt_move
      @console.print "Enter your move [0-8]: "
      @console.flush
      @console.gets.chop
    end

    def get_move
      got_input = false
      while not got_input
        str = prompt_move
        begin
          input = Integer(str)
          got_input = true if input.between?(0,8)
        rescue ArgumentError
          @console.puts "Sorry, I didn't understand your move."
          @console.puts "Please try again."
        end
      end

      input
    end

    def do_turn
      @console.puts "\nIt is the #{@current_mark}'s move."
      @console.puts @board.board_to_string
      @console.puts
      moved = false
      while not moved
        move_index = get_move
        if @board.legal?(move_index)
          @board.move(@current_mark, move_index)
          moved = true
        end
      end

      @current_mark = NEXT_PLAYER[@current_mark]
    end

    def game_loop
      @console.puts "Welcome to Tic Tac Toe!"
      while not @board.finished?
        do_turn
      end
      winner_mark = @board.who_won?
      if winner_mark
        @console.puts "The #{winner_mark}'s win!"
      else
        @console.puts "It was a draw."
      end
    end
  end

end
