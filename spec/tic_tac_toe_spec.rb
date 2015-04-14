require 'spec_helper'

class MockDisplay
end

describe TicTacToe do

  it 'has a version number' do
    expect(TicTacToe::VERSION).not_to be nil
  end

  describe TicTacToe::Game do

    it 'can start a game' do
      display = MockDisplay.new
      game = TicTacToe::Game.new display
      game.start

    end

  end

  describe TicTacToe::Board do

    before :each do
      @board = TicTacToe::Board.new
    end

    def set_board board, marks
      marks.each_with_index do |m, i|
        board.move i, m
      end
    end

    it 'initially has 9 empty positions' do
      (0..8).each do |i|
          expect(@board.pos i).to eq(" ")
      end

    end

    it 'can make moves' do
      @board.move 0, "X"
      expect(@board.pos 0).to eq("X")
      (1..8).each do |i|
        expect(@board.pos i).to eq(" ")
      end
    end

    it 'only has indices 0..8' do
      expect(@board.pos 10).to eq(nil)
    end

    def do_winning_test board, mark, places
      places.each do |n|
        board.move n, mark
      end

      expect(board.won).to eq mark
    end

    it 'knows when someone has won' do
      ["X", "O"].each do |mark|
        TicTacToe::Board.win_places.each do |places|
          board = TicTacToe::Board.new
          do_winning_test board, mark, places
        end
      end
    end

    it 'returns nil for non-won boards' do
      expect(@board.won).to eq nil

      @board.move 0, "X"
      @board.move 1, "X"
      expect(@board.won).to eq nil

      @board.move 5, "X"
      @board.move 8, "X"
      expect(@board.won).to eq nil

      @board.move 6, "X"
      expect(@board.won).to eq nil

      @board.move 2, "O"
      @board.move 3, "O"
      @board.move 4, "O"
      @board.move 7, "O"
      expect(@board.won).to eq nil
    end

    it 'knows when its a draw' do

      set_board @board, ["X", "X", "O",
                         "O", "O", "X",
                         "X", "X", "O"]
      expect(@board.draw?).to eq true
    end


  end
end
