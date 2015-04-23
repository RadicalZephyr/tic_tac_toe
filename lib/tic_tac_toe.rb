require "tic_tac_toe/version"
require "tic_tac_toe/console"
require "tic_tac_toe/board"
require "tic_tac_toe/console_shell"

module TicTacToe
  def TicTacToe.run
    g = TicTacToe::Console.new(IO::console, TicTacToe::Board.new)
    g.game_loop
  end
end
