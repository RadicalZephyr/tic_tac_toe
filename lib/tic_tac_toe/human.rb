module TicTacToe
  class Human
    attr_reader :shell

    def set_shell(shell)
      @shell = shell
    end

    def get_move(_)
      got_input = false
      while not got_input
        str = shell.prompt_move
        begin
          input = Integer(str)
          if input.between?(0,8)
            got_input = true
          else
            shell.show_invalid_move_message
          end
        rescue ArgumentError
          shell.show_move_error_message
        end
      end

      input
    end

  end
end
