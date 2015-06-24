# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rulex/version'

Gem::Specification.new do |spec|
  spec.name          = "rulex"
  spec.version       = Rulex::VERSION
  spec.authors       = ["Nicolas Mattia"]
  spec.email         = ["nicowcowo@gmail.com"]

  spec.summary       = %q{A gem for easily wrapping LaTeX code in Ruby}
  spec.homepage      = "https://www.github.com/Nicowcow/rulex"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "treetop"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
