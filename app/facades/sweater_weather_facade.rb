class SweaterWeatherFacade
  def initialize

  end

  def get_forecast_by_location(location)
    location_data = MapService.get_coordinates_by_location(location)
    coordinates = location_data[:results][0][:locations][0][:latLng]
    json = WeatherService.get_forecast_by_coordinates(coordinates[:lat], coordinates[:lng])
    Forecast.new(json)
  end

  def get_road_trip(from, to)
    destination_data = MapService.get_coordinates_by_location(to)
    coordinates = destination_data[:results][0][:locations][0][:latLng]
    route_data = MapService.get_route(from, to)

    raise Exceptions::ImpossibleRoute, route_data[:info][:messages].first if route_data[:route][:routeError] 

    route = Route.new(route_data)
    weather = WeatherService.get_eta_weather(coordinates[:lat], coordinates[:lng], route.eta_date, route.eta_hour)
    RoadTrip.new(route, weather)
  end
end