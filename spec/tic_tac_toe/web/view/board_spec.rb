require 'spec_helper'
require 'tic_tac_toe/web/view/board'

describe TicTacToe::Web::View::Board do
  let(:bv) { TicTacToe::Web::View::Board.new(TicTacToe::Core::Board.empty_board, false) }

  it 'Properly denotes row starts and ends' do
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
    expect(bv.positions).to include({:blank? => true, :mark => " ", :index => 0,
                                     :beginrow => true, :endrow => false})
  end

  it 'Renders a semblance of a board' do
    result = bv.render
    expect(result).to be_a(String).and start_with("  <table>").and end_with("  </table>\n")
    expect(result).to include("<tr>").and include("</tr>").and include("<td>").and include("</td>")
  end

  it 'renders a finished board without radio buttons' do
    boardview = TicTacToe::Web::View::Board.new(TicTacToe::Core::Board.empty_board, true)
    expect(boardview.render).not_to include("<input")
  end
end
