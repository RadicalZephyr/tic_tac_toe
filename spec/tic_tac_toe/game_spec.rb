require 'spec_helper'

describe TicTacToe::Game do

  let(:board) { mock_board }
  let(:game)  { TicTacToe::Game.new(board) }

  def mock_board
    instance_double('TicTacToe::Board').tap do |board|
      allow(board).to receive(:move)
      allow(board).to receive(:board_to_string)
      allow(board).to receive(:legal?).and_return(true)
    end
  end

  context 'when playing' do
    it 'changes the active player after every move' do
      expect { game.try_move(index: 1) }.to change { game.current_mark }
      expect { game.try_move(index: 2) }.to change { game.current_mark }
    end

    it 'changes the board marks based on user input' do
      expect(board).to receive(:move).with(anything, 1)
      game.try_move(index: 1)
    end

    it "Doesn't allow the same move twice." do
      allow(board).to receive(:legal?).and_return(true, false, true)
      expect(board).to receive(:move).with(anything, 1)
      game.try_move(index: 1)
      game.try_move(index: 1)
      game.try_move(index: 2)
    end

    it 'Keeps reading until it gets a legal move' do
      allow(board).to receive(:legal?).and_return(false, false, true)
      expect(board).to receive(:move).with(anything, 1)
      game.try_move(index: 8)
      game.try_move(index: 3)
      game.try_move(index: 1)
    end

  end
end
