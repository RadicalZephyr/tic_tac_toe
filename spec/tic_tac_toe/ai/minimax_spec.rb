require 'spec_helper'

describe TicTacToe::AI::Minimax do
  let(:ai) { TicTacToe::AI::Minimax.new("X") }

  describe 'wins when it has two in a row' do
    it 'on the left' do
      board = TicTacToe::Board.from([" ", "X", "X",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(0)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["X", " ", "X",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(1)
    end

    it 'on the right' do
      board = TicTacToe::Board.from(["X", "X", " ",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(2)
    end

  end

  describe 'blocks when the opponent would win' do
    it 'on the left' do
      board = TicTacToe::Board.from([" ", "O", "O",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(0)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["O", " ", "O",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(1)
    end

    it 'on the right' do
      board = TicTacToe::Board.from(["O", "O", " ",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(2)
    end
  end

  describe 'creates forks' do
    it 'in the center' do
      board = TicTacToe::Board.from(["X", "X", "O",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(4)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["X", " ", " ",
                                     " ", "X", " ",
                                     " ", " ", "O"])
      expect(ai.get_move(board)).to eq(1)
    end

  end
end
