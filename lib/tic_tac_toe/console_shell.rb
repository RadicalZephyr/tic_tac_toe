module TicTacToe

  class ConsoleShell
    attr_reader :game

    def initialize(console, game)
      @console, @game = console, game
    end

    def prompt_move
      @console.print "Enter your move [0-8]: "
      @console.flush
      @console.gets.chomp
    end

    def yn_to_bool(input)
      case input.downcase
      when "y", "yes"
        true
      when "n", "no"
        false
      end
    end

    def play_again?
      @console.print "Would you like to play again? "
      @console.flush
      yn_to_bool(@console.gets.chomp)
    end

    def try_again
      @console.puts "Please try again."
    end

    def show_move_error_message
      @console.puts "Sorry, I didn't understand your move."
      try_again
    end

    def show_invalid_move_message
      @console.puts "That is not a valid move choice."
      try_again
    end

    def show_illegal_move_message
      @console.puts "That move has already been played."
      try_again
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
      show_board(game.board)
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
          if input.between?(0,8)
            got_input = true
          else
            show_invalid_move_message
          end
        rescue ArgumentError
          show_move_error_message
        end
      end

      input
    end

    def do_turn
      show_board(game.board)
      moved = false
      while not moved
        moved = game.try_move(index: get_move)
        show_illegal_move_message unless moved
      end
    end

    def game_loop
      while not game.finished?
        do_turn
      end
      display_winner(game.who_won?)
    end

    def main_loop
      show_welcome_message
      loop do
        game_loop
        break unless play_again?
      end
    end

  end

end
