require 'spec_helper'
require 'tic_tac_toe/view/board'

describe TicTacToe::View::Board do

  it 'Properly denotes row starts and ends' do
    bv = TicTacToe::View::Board.new(TicTacToe::Board.empty_board)
    starts = (0...9).map { |i| bv.is_row_start?(i) }
    ends   = (0...9).map { |i| bv.is_row_end?(i) }
    expect(starts).to eq([true, false, false,
                          true, false, false,
                          true, false, false])
    expect(ends).to eq([false, false, true,
                        false, false, true,
                        false, false, true])
  end

end
