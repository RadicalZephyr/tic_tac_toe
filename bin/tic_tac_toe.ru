require 'rack_tac_toe'

use Rack::Session::Cookie,
    :key => 'tictactoe.game',
    :domain => 'localhost',
    :path => '/',
    :expire_after => 1800,
    :secret => 'my_super_secret_secret'
use Rack::Static, :urls => ["/css", "/images"], :root => "public"
run TicTacToe::RackShell.new_shell
