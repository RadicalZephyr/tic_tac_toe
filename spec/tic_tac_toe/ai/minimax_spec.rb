require 'spec_helper'
require 'rspec/expectations'

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

    it 'on the side' do
      board = TicTacToe::Board.from(["X", " ", " ",
                                     " ", "X", " ",
                                     " ", " ", "O"])
      expect(ai.get_move(board)).to eq(1)
    end

    it 'in the corner' do
      board = TicTacToe::Board.from(["X", " ", " ",
                                     " ", "O", " ",
                                     " ", " ", "X"])
      expect(ai.get_move(board)).to eq(2)
    end

    it 'in the corner' do
      board = TicTacToe::Board.from(["X", " ", "O",
                                     " ", "O", " ",
                                     " ", " ", "X"])
      expect(ai.get_move(board)).to eq(6)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["X", "O", " ",
                                     "O", " ", " ",
                                     "X", " ", " "])
      expect(ai.get_move(board)).to eq(4)
    end

    it 'in the corner or on the side' do
      board = TicTacToe::Board.from(["X", "O", " ",
                                     " ", "X", " ",
                                     " ", " ", "O"])
      expect(ai.get_move(board)).to eq(3).or eq(6)
    end
  end

  describe 'blocks opponents forks' do

    RSpec::Matchers.define :be_any_of do |a, b|
      match do |actual|
        actual == a or actual == b
      end
    end

    RSpec::Matchers.define :be_any_of do |a, b, c|
      match do |actual|
        actual == a or actual == b or actual == c
      end
    end

    RSpec::Matchers.define :be_any_of do |a, b, c, d|
      match do |actual|
        actual == a or actual == b or actual == c or actual == d
      end
    end

    it 'on the side' do
      board = TicTacToe::Board.from(["O", " ", " ",
                                     " ", "X", " ",
                                     " ", " ", "O"])
      expect(ai.get_move(board)).to be_any_of(1, 3, 5, 7)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["O", "O", "X",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(4)
    end
  end

end
