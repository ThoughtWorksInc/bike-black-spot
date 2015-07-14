require 'rack/test'
require 'csv'
require_relative '../spec_helper'

describe 'Exports' do
  describe 'get' do
    describe RoutingLocations::EXPORTS + '?users=true' do
      it 'should return redirect when not logged in' do
        get RoutingLocations::EXPORTS + '?users'
        expect(last_response.status).to be(400)
      end

      it 'should return status 200 when logged in' do
        login_as :Admin
        get RoutingLocations::EXPORTS + '?users=true'
        expect(last_response.status).to be(200)

      end
      it 'should return status 500 when given unknown params' do
        get RoutingLocations::EXPORTS + '?hello=true'
        expect(last_response.status).to be(400)
      end
      it 'should return status 500 when given unknown and correct params' do
        get RoutingLocations::EXPORTS + '?users=wow&notagoodparam'
        expect(last_response.status).to be(400)
      end

      it 'should return categories csv' do
        user_one = User.create(name: 'First name', email: 'first@email.com', confirmed: 'true')
        user_two = User.create(name: 'Second name', email: 'second@email.com', confirmed: 'true')

        login_as :Admin
        get RoutingLocations::EXPORTS + '?users=true'

        expect(CSV.parse(last_response.body)).to eql(CSV.parse(user_one.as_csv+user_two.as_csv))
      end
    end
  end
end
