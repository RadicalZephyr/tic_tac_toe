require 'spec_helper'

class MockDisplay
end

describe TicTacToe::Game do
  let(:display) { double(:display) }

  it 'can start a game' do
    allow(display).to receive(:printf)
    game = TicTacToe::Game.new display
    game.start
  end

  describe 'when playing' do
    it 'changes the active player' do
      game = TicTacToe::Game.new display

      expect { game.do_turn }.to change { game.to_play }
    end
  end


end
