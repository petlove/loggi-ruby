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

  spec.files         = Dir['{lib}/**/*', 'CHANGELOG.md', 'MIT-LICENSE', 'README.md']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3.0'

  spec.add_dependency 'activesupport', '>= 5', '< 7'
  spec.add_dependency 'http', '>= 4.1.1', '< 4.5.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'dotenv', '~> 2.7.0'
  spec.add_development_dependency 'factory_bot', '~> 6.1.0'
  spec.add_development_dependency 'faker', '~> 2.14'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5.2'
  spec.add_development_dependency 'vcr', '>= 6.0.0'
  spec.add_development_dependency 'webmock', '>= 3.10'
end
