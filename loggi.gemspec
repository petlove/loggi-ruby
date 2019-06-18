# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loggi/version'

Gem::Specification.new do |spec|
  spec.name          = 'loggi'
  spec.version       = Loggi::VERSION
  spec.authors       = ['linqueta']
  spec.email         = ['tecnologia@petlove.com.br']

  spec.licenses      = ['MIT']
  spec.summary       = 'Simple integration with Loggi API'
  spec.description   = 'Simple integration with Loggi API'
  spec.homepage      = 'https://github.com/petlove/loggi-ruby'

  spec.files         = Dir['{app,config,lib}/**/*', 'CHANGELOG.md', 'MIT-LICENSE', 'README.md']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3.0'

  spec.add_development_dependency 'bundler', '~> 2.0.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'graphql-client', '~> 0.14'
end
