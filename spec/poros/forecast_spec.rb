require "rails_helper"

RSpec.describe Forecast do
  it "can initialize with forecast attributes", :vcr do
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
    # make sure its todays hours
    expect(Time.parse(forecast.hourly_weather.first.time).strftime("%Y-%m-%d")).to eq(DateTime.parse(forecast.daily_weather.first.date).strftime("%Y-%m-%d"))
    expect(Time.parse(forecast.hourly_weather.first.time).strftime("%Y-%m-%d")).to_not eq(DateTime.parse(forecast.daily_weather[1].date).strftime("%Y-%m-%d"))

  end
end