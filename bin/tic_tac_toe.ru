require 'tic_tac_toe'

use Rack::Static, :urls => ["/css", "/images"], :root => "public"
run TicTacToe::RackShell.new_shell
