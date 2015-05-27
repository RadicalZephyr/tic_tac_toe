require 'tic_tac_toe/core/player'

module TicTacToe
  module Core
    module Players

      class Human < TicTacToe::Core::Player

        attr_reader :shell

        def initialize
          @will_block = true
          @can_retry = true
        end

        def set_shell(shell)
          @shell = shell
        end

        def get_move(_)
          shell.get_move(nil)
        end

        def set_marks(_, _)
        end
      end

    end
  end
end
