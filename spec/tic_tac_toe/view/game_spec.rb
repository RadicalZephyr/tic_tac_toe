require 'spec_helper'
require 'tic_tac_toe/view/game'

describe TicTacToe::View::Game do
  let(:game) { TicTacToe::Game.new_game(TicTacToe::Board.empty_board) }
  let(:gv) { TicTacToe::View::Game.new(game) }

  it 'can find the mustache template' do
    expect(gv.render).to be_a(String).and start_with('<!DOCTYPE html>').and end_with("</html>\n")
  end

  it 'returns the correct value for the current mark image' do
    expect(gv.current_mark).to eq("ex")
    game.move(index: 0)
    expect(gv.current_mark).to eq("oh")
  end

end
