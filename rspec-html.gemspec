# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/html/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-html'
  spec.version       = RSpec::HTML::VERSION
  spec.authors       = ['Bob Farrell']
  spec.email         = ['git@bob.frl']

  spec.summary       = 'RSpec HTML'
  spec.description   = 'HTML document abstraction and matchers for RSpec'
  spec.homepage      = 'https://github.com/bobf/rspec-html'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/LICENSE"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri', '~> 1.10'
  spec.add_dependency 'rspec', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'devpack', '~> 0.1.2'
  spec.add_development_dependency 'i18n', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec-its', '~> 1.3'
  spec.add_development_dependency 'rubocop', '~> 0.89.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.36'
  spec.add_development_dependency 'strong_versions', '~> 0.4.5'
end
