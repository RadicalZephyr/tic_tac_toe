require "tic_tac_toe/version"
require "tic_tac_toe/console/console_shell"
require "tic_tac_toe/core/board"
require "tic_tac_toe/core/mark"
require "tic_tac_toe/core/game"
require "tic_tac_toe/core/rules"
require "tic_tac_toe/ai/random"
require "tic_tac_toe/ai/minimax"

module TicTacToe

  def TicTacToe.run
    shell = TicTacToe::ConsoleShell.new_shell(IO::console)
    shell.main_loop
  end
end
