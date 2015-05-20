require 'spec_helper'
require 'tic_tac_toe/view/finished_game'

describe TicTacToe::View::FinishedGame do
  let(:player) { mock_player }
  let(:game) { test_game }
  let(:gv) { TicTacToe::View::FinishedGame.new(game) }

  def mock_player
    instance_double("TicTacToe::Human").tap do |player|
      allow(player).to receive(:set_marks)
      allow(player).to receive(:get_move).and_return(0)
    end
  end

  def test_game
    TicTacToe::Game.new(TicTacToe::Board.from(["X", " ", " ",
                                               "O", "X", "O",
                                               " ", " ", "X"]))
  end

  it 'can find the mustache template' do
    expect(gv.render).to be_a(String).and start_with('<!DOCTYPE html>').and end_with("</html>\n")
  end

  it 'displays the winning mark correctly' do
    body = gv.render
    expect(body).not_to include("<form")
    expect(body).to include("Player X Wins!")
  end
end
