require 'json'

require 'tic_tac_toe'
require 'tic_tac_toe/views'

module TicTacToe

  class RackShell

    def self.new_shell
      return RackShell.new(TicTacToe::Router.new)
    end

    def initialize(router)
      @router = router
      @router.add_route("/", :GET, TicTacToe::View::Home) { |_| nil }
      @router.add_route("/new-game", :GET, TicTacToe::View::Game) do |env|
        req = Rack::Request.new(env)
        game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
        req.session["game"] = game

        game
      end
    end

    def call(env)
      @router.match(env)
    end
  end

end
