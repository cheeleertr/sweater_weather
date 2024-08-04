class Api::V1::ForecastController < ApplicationController
  def index
    @forecast = SweaterWeatherFacade.new.get_forecast_by_location(params[:location])
    render json: ForecastSerializer.format_forecast(@forecast)
  end
end