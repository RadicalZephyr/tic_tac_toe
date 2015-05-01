module TicTacToe

  class RackShell

    def self.new_shell
      return RackShell.new
    end

    def call(env)
      [200, {}, ["Hello World"]]
    end
  end

end
