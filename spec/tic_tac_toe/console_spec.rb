require 'spec_helper'
require 'io/console'

describe TicTacToe::Console do
  let(:console) { mock_console }
  let(:board) { TicTacToe::Board.new }
  let(:game) { mock_game(board) }
  let(:console_shell) { TicTacToe::Console.new(console, game) }

  def mock_console
    instance_double('IO').tap do |console|
      allow(console).to receive(:puts)
      allow(console).to receive(:print)
      allow(console).to receive(:flush)
      allow(console).to receive(:gets).and_return("1\n")
    end
  end

  def mock_game(board)
    TicTacToe::Game.new(board).tap do |game|
      allow(game).to receive(:board).and_return(board)
      allow(game).to receive(:board=)
      allow(game).to receive(:current_mark).and_call_original
      allow(game).to receive(:current_mark=).and_call_original
    end
  end

  describe 'when playing' do

    it 'Makes a move based on user input' do
      expect(game).to receive(:try_move).with({:index => 1}).and_return(true)
      console_shell.do_turn
    end

    it 'Keeps reading until it gets a legal move' do
      expect(game).to receive(:try_move).with({:index => 1}).exactly(3).times.and_return(false, false, true)
      console_shell.do_turn
    end

  end

  describe 'when validating input' do

    def with(input:, expecting:)
      allow(console).to receive(:gets).and_return("#{input}\n")
      expect(console_shell.get_move).to eq expecting
    end

    def ignores(input:)
      allow(console).to receive(:gets).and_return("#{input}\n", "1\n")
      expect(console_shell.get_move).to eq 1
    end

    it 'keeps reading until it gets a number' do
      allow(console).to receive(:gets).and_return("abcd\n", "def\n", "{1a\n", "1\n")
      expect(console_shell.get_move).to eq 1
    end

    it 'should only return a number between 0 and 8' do
      ignores(input: "-10")
      ignores(input: "-1")
      ignores(input: "9")
      ignores(input: "15")
      with(input: "0", expecting: 0)
      with(input: "4", expecting: 4)
      with(input: "8", expecting: 8)
    end
  end

  describe 'when running the game loop' do
    it 'keeps running while the board is not complete' do
      allow(game).to receive(:try_move).and_return(true)
      expect(TicTacToe::Rules).to receive(:finished?).exactly(3).times.and_return(false, false, true)
      console_shell.game_loop
    end
  end

end
