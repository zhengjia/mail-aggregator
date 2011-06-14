$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

RACK_ENV = 'test'

require 'rspec'
require 'mongoid'
require 'simplecov'
require 'db_connection'

SimpleCov.start

RSpec.configure do |config|
  # config.mock_with :rspec
  config.before :each do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end