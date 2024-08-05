class Api::V1::BookSearchController < ApplicationController
  def index
    @forecast = SweaterWeatherFacade.new.get_forecast_by_location(params[:location])
    @books = LibraryFacade.new.books_by_search_and_limit(params[:location], params[:quantity])
    render json: ReadWeatherSerializer.format_read_weather(params[:location], @forecast, @books)
  end
end