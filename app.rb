require 'sinatra'
require 'mongoid'
require 'json'
require 'sinatra/activerecord'
require_relative 'environments'
require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'

class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :logging, Logger.new($stdout)
end
