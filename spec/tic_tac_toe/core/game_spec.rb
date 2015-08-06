require 'spec_helper'

describe TicTacToeGS::Core::Game do

  let(:player) { mock_player }
  let(:board) { TicTacToeGS::Core::Board.empty_board }
  let(:game) { test_game }

  def mock_player
    instance_double("TicTacToeGS::Core::Players::Human").tap do |player|
      allow(player).to receive(:set_marks)
      allow(player).to receive(:get_move).and_return(0)
      allow(player).to receive(:can_retry?).and_return(false)
    end
  end

  def test_game
    TicTacToeGS::Core::Game.new(board).tap do |game|
      game.reset
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

  it "can play multiple moves, as long as they don't block" do
    player2 = mock_player
    game.set_players(player, player2)
    allow(player).to receive(:will_block?).and_return(false)
    allow(player2).to receive(:will_block?).and_return(false)
    allow(player).to receive(:get_move).and_return(0,1,2)
    allow(player2).to receive(:get_move).and_return(3,4)
    game.do_nonblocking_turns
    expect(game.finished?).to be_truthy
    expect(game.who_won?).to eq(TicTacToeGS::Core::Game::X)
  end
end
