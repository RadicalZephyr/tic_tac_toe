require 'spec_helper'

class MockDisplay
end

describe TicTacToe::Game do
  let(:display) { double(:display) }
  let(:board) { mock_board }
  let(:game) { TicTacToe::Game.new(display, board) }

  def mock_board
    double(:board).tap do |board|
      allow(board).to receive(:move)
    end
  end

  it 'can start a game' do
    allow(display).to receive(:printf)
    game.start
  end

  describe 'when playing' do
    it 'changes the active player' do
      expect { game.do_turn }.to change { game.to_play }
    end

    it 'changes the board marks' do
      expect(board).to receive(:move)
      game.do_turn
    end
  end


end
