# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen/config/version'

Gem::Specification.new do |spec|
  spec.name          = 'kitchen-config'
  spec.version       = Kitchen::Config::VERSION
  spec.authors       = ['craig monson', 'lars cromley']
  spec.email         = ['craig@malachiarts.com', 'lars@callmeradical.com']
  spec.summary       = 'Basic gem for cookbook config and init.'
  spec.description   = 'This gem provides some configs and cookbook initialization'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'term-ansicolor'
end
