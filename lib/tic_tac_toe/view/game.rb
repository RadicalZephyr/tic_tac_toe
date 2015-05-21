require 'mustache'
require 'tic_tac_toe/view/board'

module TicTacToe
  module View

    class Game < Mustache
      attr_reader :game, :x_mark, :o_mark

      def self.render(game)
        if game && !game.finished?
          self.new(game).render
        elsif game && game.finished?
          FinishedGame.new(game).render
        else
          "No game was found for this session."
        end
      end

      def initialize(game)
        @game = game
        @x_mark = TicTacToe::Core::Game::X
        @o_mark = TicTacToe::Core::Game::O
      end

      def current_mark
        case game.current_mark
        when x_mark
          "ex"
        when o_mark
          "oh"
        end
      end

      def x_current
        game.current_mark == x_mark
      end

      def o_current
        game.current_mark == o_mark
      end

      def board
        TicTacToe::View::Board.render(game.board)
      end
    end

    class FinishedGame < Mustache
      attr_reader :game, :winning_mark

      def initialize(game)
        @game = game
        # This explicit nil check is to get around a weirdness in
        # mustache.  It seems mustache sees an empty string as both
        # true and false
        @winning_mark = game.who_won?.nil? ? nil : game.who_won?.to_s
      end

      def board
        TicTacToe::View::Board.render(game.board, true)
      end
    end
  end
end
