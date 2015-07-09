require 'rack/test'
require_relative '../spec_helper'
require_relative '../../routes/routing_locations'

ENV['RACK_ENV'] = 'test'
include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Admin' do
  it 'get ' + RoutingLocations::ADMIN + ' should have status 302 when unauthorised' do
    get RoutingLocations::ADMIN
    check_response_is_redirected
  end

  it 'get ' + RoutingLocations::ADMIN + ' should redirect to login when unauthorised' do
    get RoutingLocations::ADMIN
    expect(last_response.location).to include(RoutingLocations::LOGIN)
  end

  it 'get ' + RoutingLocations::ADMIN + ' should not redirect when authorised' do
    login_as :Admin
    get RoutingLocations::ADMIN
    expect(last_response.status).to_not be(302)
    check_last_response_is_ok
  end
end


