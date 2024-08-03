class SweaterWeatherFacade
  def initialize

  end

  def get_forecast_by_location(city, state)
    location_data = MapService.get_coordinates_by_location(city, state)
    coordinates = location_data[:results][0][:locations][0][:latLng]
    WeatherService.get_forecast_by_coordinates(coordinates[:lat], coordinates[:lon])

  end
end