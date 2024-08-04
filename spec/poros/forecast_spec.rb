require "rails_helper"

RSpec.describe Forecast do
  it "can initialize with forecast attributes" do
    json = WeatherService.get_forecast_by_coordinates("39.74001", "-104.99202")
    forecast = Forecast.new(json)

    expect(forecast).to be_a Forecast
    expect(forecast.current_weather).to be_a CurrentWeather

    expect(forecast.daily_weather).to be_an Array
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.daily_weather).to all(be_a DailyWeather)

    expect(forecast.hourly_weather).to be_an Array
    expect(forecast.hourly_weather.count).to eq(24)
    expect(forecast.hourly_weather).to all(be_a HourlyWeather)

  end
end