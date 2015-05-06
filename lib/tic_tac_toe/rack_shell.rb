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

      if req.path =~ %r{^/new$}
        game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
        [200, {}, [TicTacToe::View::Game.new(game).render]]

      elsif req.post? && req.path =~ %r{^/move$}
        game_hash = JSON.parse(req["game"])
        move_index = Integer(req["move"])
        board = TicTacToe::Board.from(game_hash["marks"])
        game = TicTacToe::Game.new(board)
        game.current_mark= TicTacToe::Mark.new(game_hash["current_mark"])
        game.move(index: move_index)
        [200, {}, [TicTacToe::View::Game.new(game).render]]

      else
        [404, {}, ["Not found."]]
      end
    end
  end

end
