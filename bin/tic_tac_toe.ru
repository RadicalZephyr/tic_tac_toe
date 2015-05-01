#!/usr/bin/env ruby

require "bundler/setup"
require 'rack'
require "tic_tac_toe"

Rack::Handler::WEBrick.run(
  TicTacToe::RackShell.new_shell,
  :Port => 9000
)
