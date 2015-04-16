require 'spec_helper'

class MockDisplay
end

describe TicTacToe::Game do

  it 'can start a game' do
    display = double(:display)
    allow(display).to receive(:printf)

    game = TicTacToe::Game.new display
    game.start
    expect(display).to receive(:printf)
  end

end
