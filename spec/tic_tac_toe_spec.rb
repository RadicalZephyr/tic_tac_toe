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

    it 'initially has empty positions' do
      expect(@game.pos [1,1]).to eq(" ")
    end
  end
end
