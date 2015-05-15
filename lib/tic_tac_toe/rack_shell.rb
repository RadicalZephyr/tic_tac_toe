require 'json'

require 'tic_tac_toe'
require 'tic_tac_toe/views'

module TicTacToe

  class RackShell

    def self.new_shell
      return RackShell.new
    end

    def call(env)
      req = Rack::Request.new(env)

      if req.path =~ %r{^/$}
        [200, {}, [TicTacToe::View::Home.new.render]]
      elsif req.path =~ %r{^/new-game$}
        game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
        [200, {}, [TicTacToe::View::Game.new(game).render]]
      else
        [404, {}, ["Not found."]]
      end
    end
  end

end
