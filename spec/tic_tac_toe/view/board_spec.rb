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

  it 'Returns correct position data' do
    bv = TicTacToe::View::Board.new(TicTacToe::Board.empty_board)
    expect(bv.positions).to include({:blank? => true, :mark => " ", :index => 0,
                                     :beginrow => true, :endrow => false})
  end

  it 'Renders a semblance of a board' do
    bv = TicTacToe::View::Board.new(TicTacToe::Board.empty_board)
    result = bv.render
    expect(result).to be_a(String).and start_with("  <table>").and end_with("  </table>\n")
    expect(result).to include("<tr>").and include("</tr>").and include("<td>").and include("</td>")
  end
end
