require 'spec_helper'
require 'rack'
require 'tic_tac_toe/rack_shell'

describe TicTacToe::RackShell do

  it 'can receive an index/root GET request' do
    app = TicTacToe::RackShell.new_shell
    req = Rack::MockRequest.new(app)
    response = req.get("/")
    expect(response.accepted?).to be_truthy
  end

end
