# -*- encoding: utf-8 -*-
require File.expand_path('../lib/proteste_auth/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "proteste_auth"
  spec.version       = ProtesteAuth::VERSION
  spec.authors       = ["Rodrigo Toledo"]
  spec.email         = ["rtoledo@proteste.org.br"]
  spec.description   = %q{Authentication with access control 2 with single sign on}
  spec.summary       = %q{Authentication with access control 2 with single sign on}
  spec.homepage      = ""

  spec.files         = Dir["README.md", "lib/**/*"]
  spec.test_files    = Dir["test/**/*.rb"]
  spec.require_paths = ["lib"]
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) } 

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency('activemodel')
  spec.add_dependency('actionpack')
  spec.add_runtime_dependency('ZenTest')
  spec.add_runtime_dependency('omniauth')
  spec.add_runtime_dependency('omniauth-oauth2')
end
