require 'spec_helper'

describe TicTacToe do
  it 'has a version number' do
    expect(TicTacToe::VERSION).not_to be nil
  end

  it 'has a game' do
    game = TicTacToe::Game.new
    expect(game).to be_an_instance_of TicTacToe::Game
  end
end
