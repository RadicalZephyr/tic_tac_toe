require 'mustache'
require 'tic_tac_toe/view/board'

module TicTacToe
  module View

    class FinishedGame < Mustache
      attr_reader :game, :winning_mark

      def self.render(game)
        if game
          self.new(game).render
        else
          "No game was found for this session."
        end
      end

      def initialize(game)
        @game = game
        @winning_mark = game.who_won?.to_s
      end

      def board
        TicTacToe::View::Board.render(game.board)
      end
    end

  end
end
