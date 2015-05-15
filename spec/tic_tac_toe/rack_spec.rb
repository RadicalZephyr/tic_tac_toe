require 'spec_helper'
require 'rack_spec_helper'
require 'tic_tac_toe/rack_shell'

describe TicTacToe::RackShell do
  include Rack::Test::Methods

  def app
    TicTacToe::RackShell.new_shell
  end

  it 'can receive an index/root GET request' do
    get '/'
    expect(last_response).to be_successful
    expect(last_response.body).to include("Tic-Tac-Toe")
  end

  it 'can receive an new game GET request' do
    get '/new-game'
    expect(last_response).to be_successful
    expect(last_response.body).to include("<table>")
  end

  it 'returns 404 for unknown routes' do
    get '/totally-wacky'
    expect(last_response).to be_not_found
  end
end
