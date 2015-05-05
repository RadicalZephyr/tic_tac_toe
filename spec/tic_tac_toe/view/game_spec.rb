require 'spec_helper'
require 'tic_tac_toe/view/game'

describe TicTacToe::View::Game do

  it 'can find the mustache template' do
    gv = TicTacToe::View::Game.new(TicTacToe::Game.make_new_game(TicTacToe::Board.empty_board))
    expect(gv.render).to be_a(String).and start_with('<!DOCTYPE html>').and end_with("</html>\n")
  end

end
