require 'spec_helper'

describe TicTacToe::Board do
  let(:board) { TicTacToe::Board.new }

  it 'initially has 9 empty positions' do
    (0...9).each do |i|
      expect(board.pos i).to eq(" ")
    end

  end

  it 'can make moves' do
    board.move("X", 0)
    expect(board.pos 0).to eq("X")
    (1...9).each do |i|
      expect(board.pos i).to eq(" ")
    end
  end

  it 'only has indices 0..8' do
    expect(board.pos 10).to eq(nil)
  end

  describe 'when checking if a move is legal' do
    it 'will say unmarked spaces are legal' do
      (0...9).each do |index|
        expect(board.legal?(index)).to eq true
      end
    end

    it 'will say marked spaces are not legal' do
      board.move("X", 0)
      expect(board.legal?(0)).to eq false
      (1...9).each do |index|
        expect(board.legal?(index)).to eq true
      end
    end
  end

end
