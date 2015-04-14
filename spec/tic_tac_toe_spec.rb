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

    def do_winning_test board, mark
      board.move 0, mark
      board.move 1, mark
      board.move 2, mark

      expect(board.won).to eq mark
    end

    it 'knows when someone has won' do
      ["X", "O"].each do |mark|
        board = TicTacToe::Board.new
        do_winning_test board, mark
      end

    end

  end
end
