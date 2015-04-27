module TicTacToe
  module AI

    class Random

      def initialize(random_source)
        @random_source = random_source
      end

      def get_move(board)
        @random_source.rand(8)
      end
    end

  end
end
