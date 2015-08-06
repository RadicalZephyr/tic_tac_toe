require 'mustache'

module TicTacToeGS
  module Web
    module Views

      class Board < Mustache
        attr_reader :board, :finished

        def self.render(board, finished=false)
          self.new(board, finished).render
        end

        def initialize(board, finished)
          @board, @finished = board, finished
        end

        def positions
          board.map.with_index do |mark, index|
            {:mark => mark.to_s,
             :index => index,
             :blank? => !finished && mark.blank?,
             :beginrow => is_row_start?(index),
             :endrow =>   is_row_end?(index)}
          end
        end

        def is_row_start?(index)
          (index % 3) == 0
        end

        def is_row_end?(index)
          (index % 3) == 2
        end
      end

    end
  end
end
