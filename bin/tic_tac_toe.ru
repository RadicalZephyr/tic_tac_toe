require 'rack_tac_toe'

use Rack::Session::Pool,
    :domain => 'localhost',
    :expire_after => 1800
use Rack::Static, :urls => ["/css", "/images"], :root => "public"
run TicTacToe::RackShell.new_shell
