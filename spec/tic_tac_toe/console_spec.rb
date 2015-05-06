require 'spec_helper'
require 'io/console'

describe TicTacToe::ConsoleShell do
  let(:console) { mock_console }
  let(:board) { TicTacToe::Board.empty_board }
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
    TicTacToe::Game.new_game(board).tap do |game|
      allow(game).to receive(:board).and_return(board)
      allow(game).to receive(:board=)
      allow(game).to receive(:current_mark).and_call_original
      allow(game).to receive(:current_mark=).and_call_original
    end
  end

  describe 'when playing' do

    it 'makes a move based on user input' do
      expect(game).to receive(:move).with({:index => 1})
      console_shell.do_turn
    end

    it 'keeps reading until it gets a legal move' do
      allow(console).to receive(:gets).and_return("1\n", "1\n", "2\n")
      allow(game).to receive(:move).with({:index => 1}).and_raise(ArgumentError)
      allow(game).to receive(:move).with({:index => 2})
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
      allow(game).to receive(:move)
      expect(game).to receive(:finished?).exactly(3).times.and_return(false, false, true)
      console_shell.game_loop
    end
  end

  describe 'choosing players' do
    it 'can return two human players' do
      allow(console).to receive(:gets).and_return("h\n", "h\n")
      expect(console_shell.choose_players).to include(TicTacToe::Game::X => player,
                                                      TicTacToe::Game::O => player)
    end

    it 'can return one human and one ai player' do
      allow(console).to receive(:gets).and_return("h\n", "r\n")
      expect(console_shell.choose_players).to include(TicTacToe::Game::X => player,
                                                      TicTacToe::Game::O => an_instance_of(TicTacToe::AI::Random))
    end
  end

  describe 'running the console shell' do

    it 'it only plays one game if the user says no' do
      allow(game).to receive(:finished?).and_return(true)
      allow(console).to receive(:gets).and_return("h", "h", "n")
      expect(console_shell).to receive(:game_loop).once
      console_shell.main_loop
    end

    it 'keeps playing games until the user says no' do
      allow(game).to receive(:finished?).and_return(true)
      allow(console).to receive(:gets).and_return("h", "h", "y",
                                                  "h", "h", "y",
                                                  "h", "h", "n")
      expect(console_shell).to receive(:game_loop).exactly(3).times
      console_shell.main_loop
    end

  end
end
