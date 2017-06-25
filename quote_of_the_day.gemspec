# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quote_of_the_day/version'

Gem::Specification.new do |spec|
  spec.name          = 'quote_of_the_day'
  spec.version       = QuoteOfTheDay::VERSION
  spec.authors       = ['Joel Lubrano']
  spec.email         = ['joel.lubrano@gmail.com']

  spec.summary       = 'A client for the Quote of the Day service'
  spec.homepage      = 'https://github.com/jdlubrano/quote_of_the_day-client'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'byebug', '~> 9.0.6'
  spec.add_development_dependency 'awesome_print', '~> 1.8.0'

  spec.add_dependency 'pact', '~> 1.14.0'
  spec.add_dependency 'httparty', '~> 0.15.5'
end
