require 'json'

require 'tic_tac_toe'
require 'tic_tac_toe/views'

module TicTacToe

  class RackShell
    attr_accessor :req
    def self.new_shell
      router, player = TicTacToe::Router.new, TicTacToe::Human.new
      shell = RackShell.new(router)

      router.add_route("/", :GET, TicTacToe::View::Home) { |_| nil }
      router.add_route("/new-game", :GET, TicTacToe::View::Game) do |env|
        req = Rack::Request.new(env)
        game = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
        game.set_players(player, player)
        req.session[:game] = game

        game
      end

      router.add_route("/make-move", :POST, TicTacToe::View::Game) do |env|
        shell.req= Rack::Request.new(env)
        game = shell.req.session[:game]
        if game
          game.next_turn
        end
        shell.req= nil
        game
      end

      player.set_shell(shell)

      return shell
    end

    def initialize(router)
      @router = router
    end

    def get_move
      Integer(req["move"]) unless @req.nil?
    end

    def call(env)
      @router.match(env)
    end
  end

end
