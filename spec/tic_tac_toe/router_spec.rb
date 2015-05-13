require 'spec_helper'
require 'rack_tac_toe'

describe TicTacToe::Router do
  include Rack::Test::Methods

  let(:router) { TicTacToe::Router.new }

  def app
    Proc.new do |env|
      router.match(env)
    end
  end

  it 'can add specific routes' do
    view = double
    data = {:dummy => :data}
    router.add_route("/", :GET, view) { |req| data }
    expect(view).to receive(:render).with(data)

    get '/'
  end

end
