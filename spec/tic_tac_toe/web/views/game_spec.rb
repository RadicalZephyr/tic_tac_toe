require 'spec_helper'
require 'tic_tac_toe/web/views/game'

describe TicTacToe::Web::View::Game do
  let(:player) { mock_player }
  let(:game) { test_game }
  let(:gv) { TicTacToe::Web::View::Game.new(game) }

  def mock_player
    instance_double("TicTacToe::Core::Players::Human").tap do |player|
      allow(player).to receive(:set_marks)
      allow(player).to receive(:get_move).and_return(0)
    end
  end

  def test_game
    TicTacToe::Core::Game.new_game.tap do |game|
      game.set_players(player, player)
    end
  end

  it 'can find the mustache template' do
    expect(gv.render).to be_a(String).and start_with('<!DOCTYPE html>').and end_with("</html>\n")
  end

  it 'returns the correct value for the current mark image' do
    expect(gv.current_mark).to eq("ex")
    game.next_turn
    expect(gv.current_mark).to eq("oh")
  end

end

describe TicTacToe::Web::View::FinishedGame do
  context 'with X winning' do
    let(:game) { TicTacToe::Core::Game.new(TicTacToe::Core::Board.from(["X", " ", " ",
                                                                        "O", "X", "O",
                                                                        " ", " ", "X"])) }

    it 'displays the winning mark correctly' do
      body = TicTacToe::Web::View::FinishedGame.render(game)
      expect(body).not_to include("<form")
      expect(body).to include("Player X Wins!")
    end
  end

  context 'with a draw game' do
    let(:game) { TicTacToe::Core::Game.new(TicTacToe::Core::Board.from(["X", "O", "X",
                                                                        "O", "X", "O",
                                                                        "O", "X", "O"])) }

    it 'displays the draw message' do
      body = TicTacToe::Web::View::FinishedGame.render(game)
      expect(body).not_to include("<form")
      expect(body).not_to include("Wins!")
      expect(body).to include("It's a draw!")
    end
  end
end
