module TicTacToe

  class RackShell

    def self.new_shell
      return RackShell.new
    end

    def call(env)
      if env["PATH_INFO"] =~ %r{^/set/(.*)$}
        @data = $1
        [200, {}, ["You set the data to: ", @data.to_s]]
      else
        [200, {}, ["Hello, the data is: ", @data.to_s]]
      end
    end
  end

end
