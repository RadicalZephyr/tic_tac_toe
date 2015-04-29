require 'spec_helper'

describe TicTacToe::Game do

  let(:board) { TicTacToe::Board.empty_board }
  let(:game)  { TicTacToe::Game.make_new_game(board) }

  context 'when playing' do

    it 'changes the active player after every legal move' do
      expect { game.move(index: 1) }.to change { game.current_mark }
      expect { game.move(index: 2) }.to change { game.current_mark }
    end

    it "doesn't allow the same move twice." do
      game.move(index: 1)
      expect { game.move(index:1) }.to raise_error
      game.move(index: 2)
    end

  end
end
