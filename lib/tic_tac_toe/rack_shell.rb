require 'json'

require 'tic_tac_toe'
require 'tic_tac_toe/views'

module TicTacToe

  class RackShell

    def self.new_shell
      return RackShell.new(TicTacToe::Router.new, TicTacToe::Human.new)
    end

    def initialize(router, player)
      @router, @player = router, player
      player.set_shell(self)
      @router.add_route("/", :GET, TicTacToe::View::Home) { |_| nil }
      @router.add_route("/new-game", :GET, TicTacToe::View::Game) do |env|
        req = Rack::Request.new(env)
        game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
        game.set_players(@player, @player)
        req.session[:game] = game

        game
      end
    end

    def call(env)
      @router.match(env)
    end
  end

end
