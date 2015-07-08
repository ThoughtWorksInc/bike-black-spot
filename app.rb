require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require 'warden'

require_relative 'models/init'
require_relative 'helpers/api_logger.rb'
require_relative 'routes/init'
require_relative 'environments'
require_relative 'models/admin'

class BikeSpot < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :logging, Logger.new($stdout)

  # -------------
  #     Auth
  # -------------
  Warden::Manager.serialize_into_session do |user|
    user.object_id
  end

  Warden::Manager.serialize_from_session do |object_id|
    Admin.get(object_id)
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['username'] || params['password']
    end

    def authenticate!
      # Add username stuff
    #   user = User.first(username: params['user']['username'])
    #
    #   if user.nil?
    #     fail!("The username you entered does not exist.")
    #   elsif user.authenticate(params['user']['password'])
    #     success!(user)
    #   else
    #     fail!("Could not log in")
    #   end
    # end

      admin = Admin.authenticate(params['username'], params['password'])
      admin.nil? ?  fail!('Could not log in') : success!(admin)
    end
  end

  get '/unauthenticated/?' do
    redirect '/admin/login'
  end



end

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = BikeSpot
end
