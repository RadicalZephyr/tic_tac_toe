require "tic_tac_toe/version"
require "tic_tac_toe/console_shell"
require "tic_tac_toe/board"
require "tic_tac_toe/game"
require "tic_tac_toe/rules"
require "tic_tac_toe/ai/random"

module TicTacToe

  def TicTacToe.run
    shell = TicTacToe::ConsoleShell.new_shell(IO::console)
    shell.main_loop
  end
end
