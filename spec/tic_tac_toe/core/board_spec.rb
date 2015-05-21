require 'spec_helper'

describe TicTacToe::Core::Board do
  let(:board) { TicTacToe::Core::Board.empty_board }

  it 'initially has 9 empty positions' do
    (0...9).each do |i|
      expect(board.pos(i).blank?).to be_truthy
    end

  end

  it 'can make moves' do
    board.move("X", 0)
    expect(board.pos(0)).to eq(TicTacToe::Mark.new("X"))
    (1...9).each do |i|
      expect(board.pos(i)).to eq(TicTacToe::Mark.new)
    end
  end

  it 'only has indices 0..8' do
    expect(board.pos 10).to eq(nil)
  end

  describe 'when creating empty indices' do
    it 'can handle a full board' do
      board = TicTacToe::Core::Board.from(["X", "O", "X",
                                     "X", "X", "O",
                                     "O", "X", "O"])
      expect(board.full?).to be_truthy
      expect(board.empty_spaces).to contain_exactly()
    end

    it 'can handle a mostly full board' do
      board = TicTacToe::Core::Board.from(["X", " ", "X",
                                     "X", "X", "O",
                                     "O", " ", "O"])
      expect(board.full?).to be_falsey
      expect(board.empty_spaces).to contain_exactly(1, 7)
    end

    it 'produces all indices for an empty board' do
      board = TicTacToe::Core::Board.from([" ", " ", " ",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(board.empty_spaces).to contain_exactly(*(0..8))
    end
  end

  describe 'when checking if a move is legal' do
    it 'will say unmarked spaces are legal' do
      (0...9).each do |index|
        expect(board.legal?(index)).to eq(true)
      end
    end

    it 'will say marked spaces are not legal' do
      board.move("X", 0)
      expect(board.legal?(0)).to eq(false)
      (1...9).each do |index|
        expect(board.legal?(index)).to eq(true)
      end
    end
  end

end
