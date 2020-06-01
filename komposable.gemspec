# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "komposable/version"

Gem::Specification.new do |spec|
  spec.name          = "komposable"
  spec.version       = Komposable::VERSION
  spec.authors       = ["Komposable"]
  spec.email         = ["contact@komposable.io"]

  spec.summary       = "A back-office engine for Ruby on Rails, based on components"
  spec.description   = "A back-office engine for Ruby on Rails, based on components"
  spec.homepage      = "http://komposable.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "acts_as_list", "~> 0.9.11"
  spec.add_dependency "kaminari", "~> 1.2.1"
  spec.add_dependency "komponent", "~> 1.1.4"
  spec.add_dependency "pundit", "~> 2.0.0"
  spec.add_dependency "sorcery", "~> 0.15"
  spec.add_dependency "webpacker", "~> 3.0"

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "rails", "~> 5.2"
  spec.add_development_dependency "rake", "~> 12.0"
end
