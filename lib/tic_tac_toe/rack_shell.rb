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
        [200, {}, ["Hello, and welcome to Tic-Tac-Toe!"]]
      else
        [404, {}, ["Not found."]]
      end
    end
  end

end
