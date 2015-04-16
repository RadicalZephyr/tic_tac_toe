require 'spec_helper'

describe TicTacToe::Game do
  let(:console) { mock_console }
  let(:board) { mock_board }
  let(:game) { TicTacToe::Game.new(console, board) }

  def mock_console
    double(:console).tap do |console|
      allow(console).to receive(:gets).and_return("1")
    end
  end

  def mock_board
    double(:board).tap do |board|
      allow(board).to receive(:move)
      allow(board).to receive(:legal?)
    end
  end

  it 'can start a game' do
    allow(console).to receive(:printf)
    game.start
  end

  describe 'when playing' do
    it 'changes the active player after every move' do
      expect { game.do_turn }.to change { game.to_play }
      expect { game.do_turn }.to change { game.to_play }
    end

    it 'changes the board marks based on user input' do
      allow(board).to receive(:legal?).and_return(true)
      expect(board).to receive(:move).with(anything, 1)
      game.do_turn
    end

    it "Doesn't allow the same move twice." do
      allow(console).to receive(:gets).and_return("1", "1")
      allow(board).to receive(:legal?).and_return(true, false)
      expect(board).to receive(:move).with(anything, 1)
      game.do_turn
      game.do_turn
    end
  end


end
