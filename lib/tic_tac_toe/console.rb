module TicTacToe
  class Console
    attr_reader :game

    def initialize(console, game)
      @console, @game = console, game
    end

    def prompt_move
      @console.print "Enter your move [0-8]: "
      @console.flush
      @console.gets.chop
    end

    def show_move_error_message
      @console.puts "Sorry, I didn't understand your move."
      @console.puts "Please try again."
    end

    def show_board(board)
      @console.puts "\nIt is the #{game.current_mark}'s move."
      @console.puts board.board_to_string
      @console.puts
    end

    def show_welcome_message
      @console.puts "Welcome to Tic Tac Toe!"
    end

    def display_winner(winner_mark)
      if winner_mark
        @console.puts "The #{winner_mark}'s win!"
      else
        @console.puts "It was a draw."
      end
    end

    def get_move
      got_input = false
      while not got_input
        str = prompt_move
        begin
          input = Integer(str)
          got_input = true if input.between?(0,8)
        rescue ArgumentError
          show_move_error_message
        end
      end

      input
    end

    def try_move(index:)
      game.try_move(index: index)
    end

    def do_turn
      show_board(game.board)
      moved = false
      while not moved
        move_index = get_move
        moved = try_move(index: move_index)
      end
    end

    def game_loop
      show_welcome_message
      while not game.finished?
        do_turn
      end
      display_winner(game.who_won?)
    end
  end

end
