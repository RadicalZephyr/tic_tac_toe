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
      @game = TicTacToe::Board.new
    end

    it 'initially has 9 empty positions' do
      (0..8).each do |i|
          expect(@game.pos i).to eq(" ")
      end

    end

    it 'can make moves' do
      @game.move 0, "X"
      expect(@game.pos 0).to eq("X")
      (1..8).each do |i|
        expect(@game.pos i).to eq(" ")
      end
    end

    it 'only has indices 0..8' do
      expect(@game.pos 10).to eq(nil)
    end

    it 'knows when someone has won' do
      mark = "X"
      @game.move 0, mark
      @game.move 1, mark
      @game.move 2, mark

      expect(@game.won).to eq mark
    end

  end
end
