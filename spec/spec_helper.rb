# frozen_string_literal: true

require 'bundler/setup'
require 'loggi'
require 'faker'
require 'dotenv'
require 'factory_bot'
require 'pry'
require 'webmock'
require 'vcr'
require 'support/helpers/authentication_helper'
require "awesome_print"

Dotenv.load('.env.test')

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.include Helpers::AuthenticationHelper

  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
