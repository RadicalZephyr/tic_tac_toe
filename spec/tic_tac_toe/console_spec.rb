require 'spec_helper'
require 'io/console'

describe TicTacToe::ConsoleShell do
  let(:console) { mock_console }
  let(:board) { TicTacToe::Board.new }
  let(:game) { mock_game(board) }
  let(:player) { TicTacToe::Human.new }
  let(:console_shell) { TicTacToe::ConsoleShell.new(console, game, player) }

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

  describe "handling yes or no questions" do
    it "handles y or yes as true" do
      ["y", "yes"].each do |text|
        expect(console_shell.yn_to_bool(text)).to be_truthy
      end
    end

    it "handles n or no as false" do
      ["n", "no"].each do |text|
        expect(console_shell.yn_to_bool(text)).to be_falsey
      end
    end

    it "handles anything else as nil" do
      ["ab", "euonth" "8oe02b"].each do |text|
        expect(console_shell.yn_to_bool(text)).to be_nil
      end
    end
  end

  describe 'when running the game loop' do
    it 'keeps running while the board is not complete' do
      allow(game).to receive(:try_move).and_return(true)
      expect(game).to receive(:finished?).exactly(3).times.and_return(false, false, true)
      console_shell.game_loop
    end
  end

  describe 'Running the console shell' do

    it 'it only plays one game if the user says no' do
      allow(game).to receive(:finished?).and_return(true)
      allow(console).to receive(:gets).and_return("n")
      expect(console_shell).to receive(:game_loop).once
      console_shell.main_loop
    end

    it 'keeps playing games until the user says no' do
      allow(game).to receive(:finished?).and_return(true)
      allow(console).to receive(:gets).and_return("y", "y", "n")
      expect(console_shell).to receive(:game_loop).exactly(3).times
      console_shell.main_loop
    end

  end
end
