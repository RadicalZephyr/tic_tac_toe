require 'spec_helper'

describe TicTacToe::Core::Player::Random do
  let(:randomness) { instance_double("Random") }
  let(:board) { double }
  let(:rando) { TicTacToe::Core::Player::Random.new(randomness)}

  it 'Returns random moves' do
    allow(randomness).to receive(:rand).with(8).and_return(1, 2, 3)
    expect(rando.get_move(board)).to eq(1)
    expect(rando.get_move(board)).to eq(2)
    expect(rando.get_move(board)).to eq(3)
  end
end
