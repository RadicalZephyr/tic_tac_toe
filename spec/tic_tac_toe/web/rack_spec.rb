require 'spec_helper'
require 'rack_spec_helper'
require 'json'

describe TicTacToe::Web::RackShell do
  include Rack::Test::Methods

  def app
    app = TicTacToe::Web::RackShell.new_shell
    Rack::Session::Pool.new(app, :expire_after => 18000)
  end

  it 'can receive an index/root GET request' do
    get '/'
    expect(last_response).to be_successful
    expect(last_response.body).to include("Tic-Tac-Toe")
  end

  it 'can receive an new game POST request' do
    post '/new-game', "player1=h&player2=h"
    expect(last_response).to be_successful
    expect(last_response.body).to include("<table>")
  end

  it 'can receive a make-move POST request' do
    post '/new-game', "player1=h&player2=h"
    post '/make-move', "move=1"
    expect(last_response).to be_successful
    expect(last_response.body).to include("<table>")
    expect(last_response.body).not_to include("id=\"move1\"")
  end

  it 'returns 404 for unknown routes' do
    get '/totally-wacky'
    expect(last_response).to be_not_found
  end

  context 'JSON API' do
    it 'can return the current board state' do
      post '/new-game', "player1=h&player2=h"
      get '/api/board'
      expect(last_response).to be_successful
      board_hash = JSON.parse(last_response.body)
      expect(board_hash).to include("current_mark" => "X",
                                    "marks" => [" ", " ", " ",
                                                " ", " ", " ",
                                                " ", " ", " "])
      post '/make-move', "move=1"
      get '/api/board'
      board_hash = JSON.parse(last_response.body)
      expect(board_hash).to include("current_mark" => "O",
                                    "marks" => [" ", "X", " ",
                                                " ", " ", " ",
                                                " ", " ", " "])
    end
  end
end
