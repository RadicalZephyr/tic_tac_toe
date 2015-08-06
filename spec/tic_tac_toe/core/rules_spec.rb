require 'spec_helper'

describe TicTacToeGS::Core::Rules do
  let(:board) { TicTacToeGS::Core::Board.empty_board }

  describe 'when checking if there is a winner' do
    def set_marks(board, mark, places)
      places.each do |n|
        board.move(mark, n)
      end
    end

    it 'knows when someone has won' do
      ["X", "O"].each do |mark|
        TicTacToeGS::Core::Board.win_places.each do |places|
          board = TicTacToeGS::Core::Board.empty_board
          set_marks(board, mark, places)
          expect(TicTacToeGS::Core::Rules.who_won?(board)).to eq(TicTacToeGS::Core::Mark.new(mark))
        end
      end
    end

    it 'returns nil for non-won boards' do
      expect(TicTacToeGS::Core::Rules.who_won?(board)).to eq(nil)

      board.move("X", 0)
      board.move("X", 1)
      expect(TicTacToeGS::Core::Rules.who_won?(board)).to eq(nil)

      board.move("X", 5)
      board.move("X", 8)
      expect(TicTacToeGS::Core::Rules.who_won?(board)).to eq(nil)

      board.move("X", 6)
      expect(TicTacToeGS::Core::Rules.who_won?(board)).to eq(nil)

      board.move("O", 2)
      board.move("O", 3)
      board.move("O", 4)
      board.move("O", 7)
      expect(TicTacToeGS::Core::Rules.who_won?(board)).to eq(nil)
    end
  end

  def set_board(board, marks)
    marks.each_with_index do |m, i|
      board.move(m, i)
    end
  end

  describe 'when checking for draws' do
    it 'knows when its a draw' do

      # These are the only three basic draw positions in tic-tac-toe.
      # All others are simply rotations or inversions of these three
      # forms
      set_board(board, ["X", "X", "O",
                        "O", "O", "X",
                        "X", "X", "O"])
      expect(TicTacToeGS::Core::Rules.draw?(board)).to eq(true)

      set_board(board, ["X", "X", "O",
                        "O", "X", "X",
                        "X", "O", "O"])
      expect(TicTacToeGS::Core::Rules.draw?(board)).to eq(true)

      set_board(board, ["X", "X", "O",
                        "O", "O", "X",
                        "X", "O", "x"])
      expect(TicTacToeGS::Core::Rules.draw?(board)).to eq(true)
    end

    it 'doesn\'t report false positive draws' do
      expect(TicTacToeGS::Core::Rules.draw?(board)).to eq(false)
    end
  end

  describe 'when checking if the board is done' do

    it 'is not complete if it is empty' do
      expect(TicTacToeGS::Core::Rules.finished?(board)).to eq(false)
    end

    it 'is not complete if not full' do
      set_board(board, ["X", " ", "X",
                        "O", "O", " ",
                        "X", "O", " "])
      expect(TicTacToeGS::Core::Rules.finished?(board)).to eq(false)
    end

    it 'may be not full if someone won' do
      set_board(board, ["X", "X", "X",
                        "O", "O", " ",
                        "X", "O", " "])
      expect(TicTacToeGS::Core::Rules.finished?(board)).to eq(true)
    end

    it 'is complete if there is a draw' do
      set_board(board, ["X", "X", "O",
                        "O", "X", "X",
                        "X", "O", "O"])
      expect(TicTacToeGS::Core::Rules.finished?(board)).to eq(true)
    end
  end
end
