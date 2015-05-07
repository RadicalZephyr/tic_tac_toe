require 'tic_tac_toe/mark'

module TicTacToe
  class Game
    attr_reader :current_mark, :board, :players

    X = TicTacToe::Mark.new("X")
    O = TicTacToe::Mark.new("O")

    NEXT_PLAYER = {X => O,
                   O => X}

    def self.new_game(board)
      game = TicTacToe::Game.new(board)
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
      current_player = players[current_mark]
      move(index: current_player.get_move(board))
    end

    def finished?
      TicTacToe::Rules.finished?(board)
    end

    def who_won?
      TicTacToe::Rules.who_won?(board)
    end

    private

    def move(index:)
      raise ArgumentError unless board.legal?(index)
      board.move(current_mark, index)
      swap_mark
    end

    def swap_mark
      @current_mark = NEXT_PLAYER[current_mark]
    end

  end
end
