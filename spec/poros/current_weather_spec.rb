require "rails_helper"

RSpec.describe CurrentWeather do
  it "can initialize with current weather attributes", :vcr do
    json = WeatherService.get_forecast_by_coordinates("39.74001", "-104.99202")
    forecast_data = json[:current]
    current_weather = CurrentWeather.new(forecast_data)

    expect(current_weather).to be_a CurrentWeather
    expect(current_weather.last_updated).to be_a String
    expect(current_weather.temperature).to be_a Float
    expect(current_weather.feels_like).to be_a Float
    expect(current_weather.humidity).to be_a Integer
    expect(current_weather.uvi).to be_a Float
    expect(current_weather.visibility).to be_a Float
    expect(current_weather.condition).to be_a String
    expect(current_weather.icon).to be_a String
  end
end