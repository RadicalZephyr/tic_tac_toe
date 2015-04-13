require 'spec_helper'

describe TicTacToe do
  it 'has a version number' do
    expect(TicTacToe::VERSION).not_to be nil
  end

  it 'has a board' do
    game = TicTacToe::Board.new
    expect(game).to be_an_instance_of TicTacToe::Board
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

  end

end
