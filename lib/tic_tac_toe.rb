require "tic_tac_toe/version"
require "tic_tac_toe/console_shell"
require "tic_tac_toe/board"
require "tic_tac_toe/game"
require "tic_tac_toe/rules"
require "tic_tac_toe/ai/random"

module TicTacToe

  def TicTacToe.run
    game = TicTacToe::Game.new(TicTacToe::Board.new)
    shell = TicTacToe::ConsoleShell.new(IO::console, game)
    shell.main_loop
  end
end
