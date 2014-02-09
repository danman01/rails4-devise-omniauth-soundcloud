ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/rails'
#require 'webmock/rspec' # Library for stubbing and setting expectations on HTTP requests in Ruby
require 'rubygems'
#require 'spork'
#require 'vcr'
#require 'webmock'
#require "aws-sdk"
# require everything in spec/support
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Rspec.configure do |config|
  # setup factory girl
  config.include FactoryGirl::Syntax::Methods
  # add in named routes
  config.include Rails.application.routes.url_helpers  
end


