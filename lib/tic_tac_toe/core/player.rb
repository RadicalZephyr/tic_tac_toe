module TicTacToe
  module Core

    module Player
      def will_block?
        @will_block
      end

      def can_retry?
        @can_retry
      end
    end
  end
end
