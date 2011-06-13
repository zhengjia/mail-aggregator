$:.unshift File.expand_path('../lib', File.dirname(__FILE__))

require 'rspec'
require 'mongoid'
require 'simplecov'

Mongoid.configure do |config|
  # TODO modify hard coded db name
  config.master = Mongo::Connection.new.db("mail_aggregator_test")
end

SimpleCov.start


RSpec.configure do |config|
  # config.mock_with :rspec
  config.before :each do
    Mongoid.master.collections.select {|c| c.name !~ /system/ }.each(&:drop)
  end
end