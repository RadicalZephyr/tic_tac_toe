module TicTacToe
  class Human
    attr_reader :shell

    def set_shell(shell)
      @shell = shell
    end

    def get_move(_)
      shell.get_move
    end

  end
end
