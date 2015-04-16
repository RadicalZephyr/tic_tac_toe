require 'spec_helper'

class MockDisplay
end

describe TicTacToe::Game do
  let(:display) { double(:display) }
  let(:game) { TicTacToe::Game.new display }

  it 'can start a game' do
    allow(display).to receive(:printf)
    game.start
  end

  describe 'when playing' do
    it 'changes the active player' do
      expect { game.do_turn }.to change { game.to_play }
    end
  end


end
