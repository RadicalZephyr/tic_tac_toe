require 'spec_helper'

describe TicTacToe::AI::Minimax do
  it 'wins when it has two in a row' do
    board = TicTacToe::Board.from([" ", " ", " ",
                                   " ", " ", " ",
                                   " ", " ", " "])
  end
end
