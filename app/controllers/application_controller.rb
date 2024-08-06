class ApplicationController < ActionController::API
  rescue_from Exceptions::ImpossibleRoute, with: :impossible_trip

  def valid_key 
    @valid_key = ApiKey.find_by(token: params[:api_key]) if params[:api_key]
  end
  
  private
  def impossible_trip
    render json: RoadTripSerializer.format_impossible_trip(params[:origin], params[:destination]), status: :ok
  end
end
