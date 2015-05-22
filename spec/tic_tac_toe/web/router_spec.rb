require 'spec_helper'
require 'rack_tac_toe'

describe TicTacToe::Web::Router do
  include Rack::Test::Methods

  let(:router) { TicTacToe::Web::Router.new }

  def app
    Proc.new do |env|
      router.match(env)
    end
  end

  it 'can add specific routes' do
    view = double
    data = {:dummy => :data}
    router.add_route("/", :GET, view) { |req| view.render(data) }
    router.add_route("/", :POST, view) { |req| view.render(nil) }
    router.add_route("/something-else", :GET, view) { |req| view.render(nil) }
    expect(view).to receive(:render).with(data)

    get '/'
  end

  it 'returns 404 when no route matches' do
    get '/'
    expect(last_response.not_found?).to be_truthy
  end

end
