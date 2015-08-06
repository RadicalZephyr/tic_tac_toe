require 'spec_helper'

describe TicTacToeGS::Core::Mark do

  it 'can report itself to be blank' do
    mark = TicTacToeGS::Core::Mark.new
    expect(mark.blank?).to be_truthy
  end

  it 'is not blank if it has been marked' do
    mark = TicTacToeGS::Core::Mark.new.mark("O")
    expect(mark.blank?).to be_falsey
  end

  it 'can hold a mark' do
    mark = TicTacToeGS::Core::Mark.new.mark("X")
    expect(mark.symbol).to eq("X")
  end

  it 'the default blank is equivalent to any blank' do
    expect(TicTacToeGS::Core::BLANK.blank?).to be_truthy
    expect(TicTacToeGS::Core::BLANK).to eq(TicTacToeGS::Core::Mark.new)
  end

  it 'two blank marks are equivalent' do
    expect(TicTacToeGS::Core::Mark.new == TicTacToeGS::Core::Mark.new).to be_truthy
  end

  it 'two marks with the same symbol are equivalent' do
    expect(TicTacToeGS::Core::Mark.new.mark("X") == TicTacToeGS::Core::Mark.new.mark("X")).to be_truthy
  end

  it 'should be usable as a hash key' do
    x = TicTacToeGS::Core::Mark.new("X")
    o = TicTacToeGS::Core::Mark.new("O")
    blank = TicTacToeGS::Core::Mark.new
    marks = {x => :xval,
             o => :oval,
             blank => :blankval}
    expect(marks[TicTacToeGS::Core::Mark.new("X")]).to eq(:xval)
    expect(marks[TicTacToeGS::Core::Mark.new("O")]).to eq(:oval)
    expect(marks[TicTacToeGS::Core::Mark.new]).to eq(:blankval)
  end

end
