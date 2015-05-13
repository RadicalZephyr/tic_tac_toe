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
    expect(last_response.successful?).to be_truthy
    expect(last_response.body).to include("Tic-Tac-Toe")
  end

end
