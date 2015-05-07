require 'spec_helper'

describe TicTacToe::Game do

  let(:player) { mock_player }
  let(:board) { TicTacToe::Board.empty_board }
  let(:game) { test_game }

  def mock_player
    instance_double("TicTacToe::Human").tap do |player|
      allow(player).to receive(:set_marks)
      allow(player).to receive(:get_move).and_return(0)
    end
  end

  def test_game
    TicTacToe::Game.new_game(board).tap do |game|
      game.set_players(player, player)
    end
  end

  it "swaps the mark after every turn" do
    allow(player).to receive(:get_move).and_return(0, 1)
    expect { game.next_turn }.to change { game.current_mark }
    expect { game.next_turn }.to change { game.current_mark }
  end

  it "doesn't allow the same move to happen twice" do
    game.next_turn
    expect { game.next_turn }.to raise_error
  end

end
