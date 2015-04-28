require 'spec_helper'

describe TicTacToe::Rules do
  let(:board) { TicTacToe::Board.empty_board }

  describe 'when checking if there is a winner' do
    def do_winning_test board, mark, places
      places.each do |n|
        board.move(mark, n)
      end

      expect(TicTacToe::Rules.who_won?(board)).to eq mark
    end

    it 'knows when someone has won' do
      ["X", "O"].each do |mark|
        TicTacToe::Board.win_places.each do |places|
          board = TicTacToe::Board.empty_board
          do_winning_test board, mark, places
        end
      end
    end

    it 'returns nil for non-won boards' do
      expect(TicTacToe::Rules.who_won?(board)).to eq nil

      board.move("X", 0)
      board.move("X", 1)
      expect(TicTacToe::Rules.who_won?(board)).to eq nil

      board.move("X", 5)
      board.move("X", 8)
      expect(TicTacToe::Rules.who_won?(board)).to eq nil

      board.move("X", 6)
      expect(TicTacToe::Rules.who_won?(board)).to eq nil

      board.move("O", 2)
      board.move("O", 3)
      board.move("O", 4)
      board.move("O", 7)
      expect(TicTacToe::Rules.who_won?(board)).to eq nil
    end
  end

  def set_board board, marks
    marks.each_with_index do |m, i|
      board.move(m, i)
    end
  end

  describe 'when checking for draws' do
    it 'knows when its a draw' do

      # These are the only three basic draw positions in tic-tac-toe.
      # All others are simply rotations or inversions of these three
      # forms
      set_board board, ["X", "X", "O",
                        "O", "O", "X",
                        "X", "X", "O"]
      expect(TicTacToe::Rules.draw?(board)).to eq true

      set_board board, ["X", "X", "O",
                        "O", "X", "X",
                        "X", "O", "O"]
      expect(TicTacToe::Rules.draw?(board)).to eq true

      set_board board, ["X", "X", "O",
                        "O", "O", "X",
                        "X", "O", "x"]
      expect(TicTacToe::Rules.draw?(board)).to eq true
    end

    it 'doesn\'t report false positive draws' do
      expect(TicTacToe::Rules.draw?(board)).to eq false
    end
  end

  describe 'when checking if the board is done' do

    it 'is not complete if it is empty' do
      expect(TicTacToe::Rules.finished?(board)).to eq false
    end

    it 'is not complete if not full' do
      set_board board, ["X", " ", "X",
                        "O", "O", " ",
                        "X", "O", " "]
      expect(TicTacToe::Rules.finished?(board)).to eq false
    end

    it 'may be not full if someone won' do
      set_board board, ["X", "X", "X",
                        "O", "O", " ",
                        "X", "O", " "]
      expect(TicTacToe::Rules.finished?(board)).to eq true
    end

    it 'is complete if there is a draw' do
      set_board board, ["X", "X", "O",
                        "O", "X", "X",
                        "X", "O", "O"]
      expect(TicTacToe::Rules.finished?(board)).to eq true
    end
  end
end
