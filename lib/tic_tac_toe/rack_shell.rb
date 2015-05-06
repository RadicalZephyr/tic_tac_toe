require 'tic_tac_toe'
require 'tic_tac_toe/views'

module TicTacToe

  class RackShell

    def self.new_shell
      return RackShell.new
    end

    def call(env)
      if env["PATH_INFO"] =~ %r{^/new$}
        @game = TicTacToe::Game.new(TicTacToe::Board.empty_board)
        [200, {}, [TicTacToe::View::Game.new(@game).render]]
      else
        [404, {}, ["Not found."]]
      end
    end
  end

end
