# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ngxmodgen/version'

Gem::Specification.new do |spec|
  spec.name          = "ngxmodgen"
  spec.version       = Ngxmodgen::VERSION
  spec.authors       = ["Tatsuhiko Kubo"]
  spec.email         = ["cubicdaiya@gmail.com"]
  spec.description   = %q{Nginx Module Generator}
  spec.summary       = %q{Nginx Module Generator}
  spec.homepage      = "https://github.com/cubicdaiya/ngxmodgen-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
