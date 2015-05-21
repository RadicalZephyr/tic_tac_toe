require 'rack_tac_toe'

use Rack::Session::Pool,
    :expire_after => 1800
use Rack::Static, :urls => ["/js", "/css", "/images"], :root => "public"
run TicTacToe::Web::RackShell.new_shell
