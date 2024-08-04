class SweaterWeatherFacade
  def initialize

  end

  def get_forecast_by_location(location)
    location_data = MapService.get_coordinates_by_location(location)
    coordinates = location_data[:results][0][:locations][0][:latLng]
    json = WeatherService.get_forecast_by_coordinates(coordinates[:lat], coordinates[:lng])
    Forecast.new(json)
  end
end