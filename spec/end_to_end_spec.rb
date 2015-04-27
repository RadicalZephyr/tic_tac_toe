require 'spec_helper'
require 'io/console'

describe "Playing a full game" do
  let(:console) { mock_console }
  let(:board)   { TicTacToe::Board.new }
  let(:game)    { TicTacToe::Game.new(board) }
  let(:shell)   { TicTacToe::ConsoleShell.new(console, game) }

  def mock_console
    instance_double('IO').tap do |console|
      allow(console).to receive(:puts)
      allow(console).to receive(:print)
      allow(console).to receive(:flush)
    end
  end

  def make_moves(xs, ys)
    moves = xs.zip(ys).flatten.compact
    moves.map { |move| move.to_s + "\n" }
  end

  def with_moves(x_moves:, y_moves:)
    inputs = make_moves(x_moves, y_moves)
    expect(console).to receive(:gets).and_return(*inputs)
  end

  it "ends after a win" do
    x_moves = [0, 1, 2]
    y_moves = [3, 4]
    with_moves(x_moves: x_moves, y_moves: y_moves)
    shell.game_loop
  end

  it "ends after a draw" do
    x_moves = [0, 1, 3, 8, 4]
    y_moves = [2, 6, 7, 5]
    with_moves(x_moves: x_moves, y_moves: y_moves)
    shell.game_loop
  end

  it 'plays multiple games from main loop' do
    x_moves = [0, 1, 3, 8, 4]
    y_moves = [2, 6, 7, 5]
    moves = [make_moves(x_moves, y_moves)] * 2
    inputs = moves.zip(["y\n", "n\n"]).flatten.compact
    expect(console).to receive(:gets).and_return(*inputs)
    expect(shell).to receive(:game_loop).twice.and_call_original
    shell.main_loop
  end
end
