require 'spec_helper'

describe TicTacToe::Game do

  let(:board) { mock_board }
  let(:game)  { TicTacToe::Game.new(board) }

  def mock_board
    instance_double('TicTacToe::Board').tap do |board|
      allow(board).to receive(:move)
      allow(board).to receive(:board_to_string)
      allow(board).to receive(:legal?).and_return(true)
    end
  end

end
