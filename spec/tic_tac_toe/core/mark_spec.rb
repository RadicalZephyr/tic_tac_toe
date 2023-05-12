require 'spec_helper'

describe TicTacToeRZ::Core::Mark do

  it 'can report itself to be blank' do
    mark = TicTacToeRZ::Core::Mark.new
    expect(mark.blank?).to be_truthy
  end

  it 'is not blank if it has been marked' do
    mark = TicTacToeRZ::Core::Mark.new.mark("O")
    expect(mark.blank?).to be_falsey
  end

  it 'can hold a mark' do
    mark = TicTacToeRZ::Core::Mark.new.mark("X")
    expect(mark.symbol).to eq("X")
  end

  it 'the default blank is equivalent to any blank' do
    expect(TicTacToeRZ::Core::BLANK.blank?).to be_truthy
    expect(TicTacToeRZ::Core::BLANK).to eq(TicTacToeRZ::Core::Mark.new)
  end

  it 'two blank marks are equivalent' do
    expect(TicTacToeRZ::Core::Mark.new == TicTacToeRZ::Core::Mark.new).to be_truthy
  end

  it 'two marks with the same symbol are equivalent' do
    expect(TicTacToeRZ::Core::Mark.new.mark("X") == TicTacToeRZ::Core::Mark.new.mark("X")).to be_truthy
  end

  it 'should be usable as a hash key' do
    x = TicTacToeRZ::Core::Mark.new("X")
    o = TicTacToeRZ::Core::Mark.new("O")
    blank = TicTacToeRZ::Core::Mark.new
    marks = {x => :xval,
             o => :oval,
             blank => :blankval}
    expect(marks[TicTacToeRZ::Core::Mark.new("X")]).to eq(:xval)
    expect(marks[TicTacToeRZ::Core::Mark.new("O")]).to eq(:oval)
    expect(marks[TicTacToeRZ::Core::Mark.new]).to eq(:blankval)
  end

end
