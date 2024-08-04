require "rails_helper"

RSpec.describe HourlyWeather do
  it "can initialize with hourly weather attributes" do
    json = WeatherService.get_forecast_by_coordinates("39.74001", "-104.99202")
    todays_hourly_data = json[:forecast][:forecastday][0][:hour][0]
    hourly_weather = HourlyWeather.new(todays_hourly_data)

    expect(hourly_weather).to be_a HourlyWeather
    expect(hourly_weather.time).to be_a String
    expect(hourly_weather.temperature).to be_a Float
    expect(hourly_weather.condition).to be_a String
    expect(hourly_weather.icon).to be_a String
  end
end