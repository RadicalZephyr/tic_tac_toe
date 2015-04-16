module TicTacToe
  class Game
    attr_reader :to_play

    def initialize display
      @display = display
      @to_play = "X"
    end

    def start
      @display.printf "Welcome to Tic Tac Toe"
    end

    def do_turn
      @to_play = "O"
    end
  end

end
