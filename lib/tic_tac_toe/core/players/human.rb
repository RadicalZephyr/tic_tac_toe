module TicTacToe
  module Player

    class Human
      attr_reader :shell

      def set_shell(shell)
        @shell = shell
      end

      def get_move(_)
        shell.get_move
      end

      def set_marks(_, _)
      end
    end

  end
end
