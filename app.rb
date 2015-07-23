require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'bcrypt'
require 'rack/throttle'
require 'rack/ssl'
require 'geokit'
require 'warden'

require_relative 'app/models/init'
require_relative 'app/routes/init'
require_relative 'app/models/admin'
require_relative 'app/helpers/bike_spot_warden'
require_relative 'config/environments'

use Rack::Throttle::Minute, :max => 1000 if ENV['RACK_ENV'] == 'production'
use Rack::SSL, :exclude => lambda { |env| ENV['RACK_ENV'] != 'production' }

set :logging, true
set :session, true

class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  Sinatra::Base.set :views, File.join(File.dirname(__FILE__),'/app/views/')
end
