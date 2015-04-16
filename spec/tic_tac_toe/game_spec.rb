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
    end
  end

  it 'can start a game' do
    allow(console).to receive(:printf)
    game.start
  end

  describe 'when playing' do
    it 'changes the active player' do
      expect { game.do_turn }.to change { game.to_play }
    end

    it 'changes the board marks based on user input' do
      expect(console).to receive(:gets)
      expect(board).to receive(:move).with("X", 1)
      game.do_turn
    end
  end


end
