require_relative 'routing_locations'
require_relative '../helpers/param_validation_helper'

get RoutingLocations::REPORTS + '/?' do
  permitted = %w(uuid)
  required = %w()
  return status 400 unless validate_params?(params, permitted, required)

  if params[:uuid].nil?
    return Report.all.to_json if warden.authenticated?

    result = Report.all.reject { |column| Report.requires_auth?(column) }
    return result.to_json
  end
  report = Report.find_by(uuid: params[:uuid])
  # status 400 if report.nil?
  return report.to_json
end


post RoutingLocations::REPORTS do
  permitted = %w(uuid lat long category description)
  required = %w(uuid lat long category)
  return status 400 unless validate_params?(params, permitted, required)

  user = User.find_by(uuid: params[:uuid])
  category = Category.find_by(uuid: params[:category])
  return status 400 if user.nil? or category.nil?

  Report.create(user: user, category: category, lat: params[:lat], long: params[:long],
                description: params[:description])
  return status 201
end

