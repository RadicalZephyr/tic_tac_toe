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
      game.set_players(player, player)
    end

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

    def get_human
      @player
    end

    def get_player(mark, other_mark)
      loop do
        case prompt_player(mark)
        when "h", "human"
          return @player
        when "r", "random"
          return TicTacToe::AI::Random.new(Random.new)
        when "a", "ai"
          return TicTacToe::AI::Minimax.new(mark, other_mark)
        end
      end
    end

    def choose_players
      [get_player(TicTacToe::Game::X,
                  TicTacToe::Game::O),
       get_player(TicTacToe::Game::O,
                  TicTacToe::Game::X)]
    end

    def do_turn
      show_move_message
      show_board(game.board)
      moved = false
      current_player = game.players[game.current_mark]
      while not moved
        begin
          game.move(index: current_player.get_move(game.board))
          moved = true
        rescue ArgumentError
          show_illegal_move_message
        end
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
        game.set_players(*choose_players)
        game_loop
        break unless play_again?
        game.reset
      end
    end

  end

end
