require 'spec_helper'
require 'io/console'

describe TicTacToe::Game do
  let(:console) { mock_console }
  let(:board) { mock_board }
  let(:game) { TicTacToe::Game.new(console, board) }

  def mock_console
    instance_double("IO").tap do |console|
      allow(console).to receive(:puts)
      allow(console).to receive(:print)
      allow(console).to receive(:oflush)
      allow(console).to receive(:gets).and_return("1")
    end
  end

  def mock_board
    double(:board).tap do |board|
      allow(board).to receive(:move)
      allow(board).to receive(:legal?).and_return(true)
    end
  end

  it 'can start a game' do
    allow(console).to receive(:printf)
    game.start
  end

  describe 'when playing' do
    it 'changes the active player after every move' do
      expect { game.do_turn }.to change { game.to_play }
      expect { game.do_turn }.to change { game.to_play }
    end

    it 'changes the board marks based on user input' do
      expect(board).to receive(:move).with(anything, 1)
      game.do_turn
    end

    it "Doesn't allow the same move twice." do
      allow(console).to receive(:gets).and_return("1")
      allow(board).to receive(:legal?).and_return(true, false, true)
      expect(board).to receive(:move).with(anything, 1)
      game.do_turn
      game.do_turn
    end

    it 'Keeps reading until it gets a legal move' do
      allow(console).to receive(:gets).and_return("1")
      allow(board).to receive(:legal?).and_return(false, false, true)
      expect(board).to receive(:move).with(anything, 1)
      game.do_turn
    end

  end

  describe 'when validating input' do

    def with(input:, expect:)
      allow(console).to receive(:gets).and_return(input)
      expect(game.get_move).to eq expect
    end

    def ignores(input:)
      allow(console).to receive(:gets).and_return(input, "1")
      expect(game.get_move).to eq 1
    end

    it 'keeps reading until it gets a number' do
      allow(console).to receive(:gets).and_return("abcd", "def", "{1a", "1")
      expect(game.get_move).to eq 1
    end

    it 'should only return a number between 0 and 8' do
      ignores(input: "-10")
      ignores(input: "-1")
      ignores(input: "9")
      ignores(input: "15")
      with(input: "0", expect: 0)
      with(input: "4", expect: 4)
      with(input: "8", expect: 8)
    end
  end

  describe 'when running the game loop' do
    it 'keeps running while the board is not complete' do
      allow(board).to receive(:finished?).and_return(false, false, true)
      expect(board).to receive(:finished?).exactly(3).times
      game.game_loop
    end
  end

end
