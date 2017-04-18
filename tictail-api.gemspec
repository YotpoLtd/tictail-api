# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tictail/api/version'

Gem::Specification.new do |spec|
  spec.name          = 'tictail-api'
  spec.version       = Tictail::Api::VERSION
  spec.authors       = ['Alon Braitstein']
  spec.email         = ['alon@yotpo.com']
  spec.description   = %q{Ruby wrapper for tictail API - written by Yotpo}
  spec.summary       = %q{Ruby wrapper for tictail API - written by Yotpo}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'

  spec.add_dependency 'faraday'
  spec.add_dependency 'typhoeus'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'faraday_middleware-multi_json'
end
