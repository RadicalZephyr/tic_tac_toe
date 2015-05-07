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
      allow(game).to receive(:current_mark).and_call_original
      allow(game).to receive(:current_mark=).and_call_original
      game.set_players(player, player)
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
