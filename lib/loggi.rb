# frozen_string_literal: true

require 'loggi/version'
require 'loggi/configuration'
require 'loggi/credential'
require 'loggi/shop'
require 'loggi/address'
require 'loggi/charge_option'
require 'loggi/services/base'
require 'loggi/services/authentication'
require 'loggi/services/shops'
require 'http'
require 'active_support/all'
require 'pry'

module Loggi
  class Error < StandardError; end
  # Your code goes here...
end
