class Api::V1::RoadTripController < ApplicationController
  def index
    return render  json: ErrorSerializer.new(ErrorMessage.new("Invalid Credentials", 401)).serialize_json, status: :unauthorized if valid_key.nil?

    @road_trip = SweaterWeatherFacade.new.get_road_trip(params[:origin], params[:destination])
    render json: RoadTripSerializer.format_road_trip(@road_trip, params[:origin], params[:destination])
  end
end