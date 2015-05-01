require 'spec_helper'

describe TicTacToe::Mark do

  it 'can report itself to be blank' do
    mark = TicTacToe::Mark.new
    expect(mark.blank?).to be_truthy
  end

  it 'can hold a mark' do
    mark = TicTacToe::Mark.new.mark("X")
    expect(mark.symbol).to eq("X")
  end
end
