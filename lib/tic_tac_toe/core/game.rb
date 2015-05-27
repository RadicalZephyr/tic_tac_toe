require 'tic_tac_toe/core/mark'
require 'tic_tac_toe/core/board'

module TicTacToe
  module Core

    class IllegalMove < ArgumentError
      attr_reader :move, :board

      def initialize(message=nil, move=nil, board=nil)
        super(message)
        @move = move
        @board = board
      end
    end

    class Game
      attr_reader :current_mark, :board, :players
      attr_accessor :illegal_move_handler

      X = TicTacToe::Core::Mark.new("X")
      O = TicTacToe::Core::Mark.new("O")

      NEXT_PLAYER = {X => O,
                     O => X}

      def self.new_game()
        board = TicTacToe::Core::Board.empty_board
        game = TicTacToe::Core::Game.new(board)
        game.reset
      end

      def initialize(board)
        @board = board
      end

      def reset
        @current_mark = X
        board.reset
        return self
      end

      def set_players(first_player, second_player)
        @players = {X => first_player,
                    O => second_player}
        first_player.set_marks(X, O)
        second_player.set_marks(O, X)
      end

      def next_turn
        moved = false
        until moved
          begin
            move(index: current_player.get_move(board))
            moved = true
          rescue IllegalMove => err
            illegal_move_handler.call if illegal_move_handler
            raise err unless current_player.can_retry?
          end
        end
      end

      def do_nonblocking_turns
        loop do
          next_turn
          break if finished? or current_player.will_block?
        end
      end

      def finished?
        TicTacToe::Core::Rules.finished?(board)
      end

      def who_won?
        TicTacToe::Core::Rules.who_won?(board)
      end

      private

      def current_player
        players[current_mark]
      end

      def move(index:)
        raise IllegalMove.new(nil, index, board) unless board.legal?(index)
        board.move(current_mark, index)
        swap_mark
      end

      def swap_mark
        @current_mark = NEXT_PLAYER[current_mark]
      end

    end

  end
end
