# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tic_tac_toe_rs/version'

Gem::Specification.new do |spec|
  spec.name          = "tic_tac_toe_rz"
  spec.version       = TicTacToeRZ::VERSION
  spec.authors       = ["Zefira Shannon"]
  spec.email         = ["zefira@hey.com"]

  spec.summary       = %q{Ruby Tic Tac Toe, done tests first and with good OOD}
  spec.description   = %q{Not much to see here. This is a ruby library built for running the internals of a Tic Tac Toe game.}
  spec.homepage      = "https://github.com/RadicalZephyr/tic_tac_toe"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "3.2.0"
  spec.add_development_dependency "guard-rspec", "4.5.0"

end
