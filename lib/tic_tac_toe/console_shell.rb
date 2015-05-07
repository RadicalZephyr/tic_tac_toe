require 'tic_tac_toe/human'
require 'tic_tac_toe/game'

module TicTacToe

  class ConsoleShell
    attr_reader :game

    def self.new_shell(console)
      game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
      player = TicTacToe::Human.new
      TicTacToe::ConsoleShell.new(console, game, player)
    end

    def initialize(console, game, player)
      @console, @game, @player = console, game, player
      player.set_shell(self)
    end

    def main_loop
      show_welcome_message
      loop do
        play_game
        break unless play_again?
        game.reset
      end
    end

    def play_game
      game.set_players(*choose_players)
      game_loop
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


    private

    def game_loop
      while not game.finished?
        do_turn
      end
      display_winner(game.who_won?)
    end

    def do_turn
      show_move_message
      show_board(game.board)
      moved = false
      while not moved
        begin
          game.next_turn
          moved = true
        rescue ArgumentError
          show_illegal_move_message
        end
      end
    end

    def get_human
      @player
    end

    def get_player(mark)
      loop do
        case prompt_player(mark)
        when "h", "human"
          return @player
        when "r", "random"
          return TicTacToe::AI::Random.new(Random.new)
        when "a", "ai"
          return TicTacToe::AI::Minimax.new
        end
      end
    end

    def choose_players
      [get_player("X"), get_player("O")]
    end


    ########################################
    ## I/O Methods
    ########################################

    def prompt_move
      @console.print "Enter your move [0-8]: "
      @console.flush
      @console.gets.chomp
    end

    def prompt_player(mark)
      @console.print "Who should play #{mark}'s ([h]uman, [r]andom or [a]i)? "
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

    def show_move_message
      @console.puts "\nIt is the #{game.current_mark}'s move."
    end

    def show_board(board)
      @console.puts board
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

  end

end
