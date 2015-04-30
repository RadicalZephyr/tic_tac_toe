require 'spec_helper'
require 'rspec/expectations'

describe TicTacToe::AI::Minimax do
  let(:ai) { TicTacToe::AI::Minimax.new("X", "O") }

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
                                     " ", "O", "X",
                                     "X", "X", "O"])
      expect(ai.get_move(board)).to eq(0)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["O", " ", "O",
                                     "O", " ", "X",
                                     "X", "O", "x"])
      expect(ai.get_move(board)).to eq(1)
    end

    it 'on the right' do
      board = TicTacToe::Board.from(["O", "O", " ",
                                     "O", "X", " ",
                                     "X", "X", "O"])
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

    it 'on the side' do
      board = TicTacToe::Board.from([" ", " ", "O",
                                     " ", "X", " ",
                                     "O", " ", " "])
      expect(ai.get_move(board)).to be_any_of(1, 3, 5, 7)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["O", "O", "X",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to be_any_of(4, 5)
    end

    it 'in the center' do
      board = TicTacToe::Board.from(["O", " ", " ",
                                     " ", "O", " ",
                                     " ", " ", "X"])
      expect(ai.get_move(board)).to be_any_of(2, 6)
    end
  end

  describe 'plays second correctly' do
    it 'from a corner opening' do
      board = TicTacToe::Board.from(["O", " ", " ",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to eq(4)
    end

    it 'from a center opening' do
      board = TicTacToe::Board.from([" ", " ", " ",
                                     " ", "O", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to be_any_of(0, 2, 6, 8)
    end

    it 'from a side opening' do
      board = TicTacToe::Board.from([" ", "O", " ",
                                     " ", " ", " ",
                                     " ", " ", " "])
      expect(ai.get_move(board)).to be_any_of(4, 0, 2, 7)
    end
  end

  describe 'negamax' do
    it 'scores an immediate loss as -10' do
      board = TicTacToe::Board.from(["O", "O", "O",
                                     " ", " ", " ",
                                     " ", " ", " "])

      expect(ai.negamax({1  => "X", -1 => "O"}, board, 10, -100, 100, 1)).to eq([-1, -100])
    end

    it 'scores an immediate win as 10' do
      board = TicTacToe::Board.from(["X", "X", "X",
                                     " ", " ", " ",
                                     " ", " ", " "])

      expect(ai.negamax({1  => "X", -1 => "O"}, board, 10, -100, 100, 1)).to eq([-1, 100])
    end
  end

  describe 'recognizes forks' do
    it 'as two lines of attack' do
      board = TicTacToe::Board.from(["X", "X", " ",
                                     "X", " ", " ",
                                     " ", " ", " "])

      expect(ai.has_fork?(board)).to eq("X")
    end

    it 'for either player' do
      board = TicTacToe::Board.from(["O", "O", " ",
                                     "O", " ", " ",
                                     " ", " ", " "])

      expect(ai.has_fork?(board)).to eq("O")
    end
  end

end
