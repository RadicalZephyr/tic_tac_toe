# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tic_tac_toe_gs/version'

Gem::Specification.new do |spec|
  spec.name          = "tic_tac_toe_gs"
  spec.version       = TicTacToeGS::VERSION
  spec.authors       = ["Zefira Shannon"]
  spec.email         = ["zefira@hey.com"]

  spec.summary       = %q{Ruby Tic Tac Toe, done tests first and with good OOD}
  spec.description   = %q{Not much to see here. This is a ruby library built for running the internals of a Tic Tac Toe game.}
  spec.homepage      = "https://github.com/RadicalZephyr/tic_tac_toe"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rack", "~> 1.6"
  spec.add_runtime_dependency "mustache", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "3.2.0"
  spec.add_development_dependency "rack-test", "0.6.3"
  spec.add_development_dependency "jasmine", "2.3.0"
  spec.add_development_dependency "guard-rspec", "4.5.0"
  spec.add_development_dependency "guard-rack", "2.1.1"
  spec.add_development_dependency "guard-jasmine", "2.0.6"
  spec.add_development_dependency "pry", "0.10.1"
  spec.add_development_dependency "pry-byebug", "3.1.0"
  spec.add_development_dependency "hijack", "0.2.1"

end
