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

  it 'two blank marks are equivalent' do
    expect(TicTacToe::Mark.new == TicTacToe::Mark.new).to be_truthy
  end

  it 'two marks with the same symbol are equivalent' do
    expect(TicTacToe::Mark.new.mark("X") == TicTacToe::Mark.new.mark("X")).to be_truthy
  end
end