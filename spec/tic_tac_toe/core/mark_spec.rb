require 'spec_helper'

describe TicTacToe::Mark do

  it 'can report itself to be blank' do
    mark = TicTacToe::Mark.new
    expect(mark.blank?).to be_truthy
  end

  it 'is not blank if it has been marked' do
    mark = TicTacToe::Mark.new.mark("O")
    expect(mark.blank?).to be_falsey
  end

  it 'can hold a mark' do
    mark = TicTacToe::Mark.new.mark("X")
    expect(mark.symbol).to eq("X")
  end

  it 'the default blank is equivalent to any blank' do
    expect(TicTacToe::BLANK.blank?).to be_truthy
    expect(TicTacToe::BLANK).to eq(TicTacToe::Mark.new)
  end

  it 'two blank marks are equivalent' do
    expect(TicTacToe::Mark.new == TicTacToe::Mark.new).to be_truthy
  end

  it 'two marks with the same symbol are equivalent' do
    expect(TicTacToe::Mark.new.mark("X") == TicTacToe::Mark.new.mark("X")).to be_truthy
  end

  it 'should be usable as a hash key' do
    x = TicTacToe::Mark.new("X")
    o = TicTacToe::Mark.new("O")
    blank = TicTacToe::Mark.new
    marks = {x => :xval,
             o => :oval,
             blank => :blankval}
    expect(marks[TicTacToe::Mark.new("X")]).to eq(:xval)
    expect(marks[TicTacToe::Mark.new("O")]).to eq(:oval)
    expect(marks[TicTacToe::Mark.new]).to eq(:blankval)
  end

end
