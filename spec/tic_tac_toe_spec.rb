require 'spec_helper'

class MockDisplay
end

describe TicTacToe do

  it 'has a version number' do
    expect(TicTacToe::VERSION).not_to be nil
  end

  describe TicTacToe::Game do

    it 'can start a game' do
      display = MockDisplay.new
      game = TicTacToe::Game.new display
      game.start

    end

  end


end
