require 'tic_tac_toe/core/player'

module TicTacToe
  module Core
    module Players

      class Random < TicTacToe::Core::Player

        def initialize(random_source)
          @random_source = random_source
          @will_block = false
          @can_retry = true
        end

        def get_move(board)
          @random_source.rand(8)
        end

        def set_marks(_, _)
        end
      end

    end
  end
end
