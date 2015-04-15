require 'spec_helper'

class MockDisplay
end

describe TicTacToe::Game do

  it 'can start a game' do
    display = MockDisplay.new
    game = TicTacToe::Game.new display
    game.start

  end

end
