require 'spec_helper'

describe TicTacToe::Core::Mark do

  it 'can report itself to be blank' do
    mark = TicTacToe::Core::Mark.new
    expect(mark.blank?).to be_truthy
  end

  it 'is not blank if it has been marked' do
    mark = TicTacToe::Core::Mark.new.mark("O")
    expect(mark.blank?).to be_falsey
  end

  it 'can hold a mark' do
    mark = TicTacToe::Core::Mark.new.mark("X")
    expect(mark.symbol).to eq("X")
  end

  it 'the default blank is equivalent to any blank' do
    expect(TicTacToe::Core::BLANK.blank?).to be_truthy
    expect(TicTacToe::Core::BLANK).to eq(TicTacToe::Core::Mark.new)
  end

  it 'two blank marks are equivalent' do
    expect(TicTacToe::Core::Mark.new == TicTacToe::Core::Mark.new).to be_truthy
  end

  it 'two marks with the same symbol are equivalent' do
    expect(TicTacToe::Core::Mark.new.mark("X") == TicTacToe::Core::Mark.new.mark("X")).to be_truthy
  end

  it 'should be usable as a hash key' do
    x = TicTacToe::Core::Mark.new("X")
    o = TicTacToe::Core::Mark.new("O")
    blank = TicTacToe::Core::Mark.new
    marks = {x => :xval,
             o => :oval,
             blank => :blankval}
    expect(marks[TicTacToe::Core::Mark.new("X")]).to eq(:xval)
    expect(marks[TicTacToe::Core::Mark.new("O")]).to eq(:oval)
    expect(marks[TicTacToe::Core::Mark.new]).to eq(:blankval)
  end

end
