require 'spec_helper'
require 'tic_tac_toe/view/game'

describe TicTacToe::View::Game do

  it 'can find the mustache template' do
    gv = TicTacToe::View::Game.new(TicTacToe::Game.make_new_game(TicTacToe::Board.empty_board))
    gv.render
  end

end
