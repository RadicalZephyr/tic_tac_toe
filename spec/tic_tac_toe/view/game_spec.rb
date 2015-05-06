require 'spec_helper'
require 'tic_tac_toe/view/game'

describe TicTacToe::View::Game do

  it 'can find the mustache template' do
    gv = TicTacToe::View::Game.new(TicTacToe::Game.new_game(TicTacToe::Board.empty_board))
    expect(gv.render).to be_a(String).and start_with('<!DOCTYPE html>').and end_with("</html>\n")
  end

  it 'returns the correct value for the current mark image' do
    g = TicTacToe::Game.new_game(TicTacToe::Board.empty_board)
    gv = TicTacToe::View::Game.new(g)
    expect(gv.current_mark).to eq("ex")
    g.move(index: 0)
    expect(gv.current_mark).to eq("oh")
  end

end
