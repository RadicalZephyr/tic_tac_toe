module TicTacToe
  module Core

    class Player
      def initialize
        @will_block = true
        @can_retry = false
      end

      def will_block?
        @will_block
      end

      def can_retry?
        @can_retry
      end
    end
  end
end
