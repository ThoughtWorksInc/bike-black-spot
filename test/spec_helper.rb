require 'sinatra'
require 'rspec'
require 'json'
require 'rack/test'
require 'database_cleaner'

include Rack::Test::Methods
require File.join(File.dirname(__FILE__), '../app')

def app
  Sinatra::Application
end
	
# set test environment
Sinatra::Base.set :environment, :test
Sinatra::Base.set :run, false
Sinatra::Base.set :raise_errors, true
Sinatra::Base.set :logging, false # ?? not using this logging?
Sinatra::Base.set :views, File.join(File.dirname(__FILE__),'../views/')

RSpec.configure do |config|
  config.include Warden::Test::Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after do
    Warden.test_reset!
  end
end

def check_last_response_is_ok
  expect(last_response).to be_ok
end

def check_response_is_redirected
  expect(last_response.status).to be(302)
end
