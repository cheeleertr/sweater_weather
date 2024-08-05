require "rails_helper"

RSpec.describe DailyWeather do
  it "can initialize with daily weather attributes", :vcr do
    json = WeatherService.get_forecast_by_coordinates("39.74001", "-104.99202")
    daily_data = json[:forecast][:forecastday][0]
    dailyweather = DailyWeather.new(daily_data)

    expect(dailyweather).to be_a DailyWeather
    expect(dailyweather.date).to be_a String
    expect(dailyweather.sunrise).to be_a String
    expect(dailyweather.sunset).to be_a String
    expect(dailyweather.max_temp).to be_a Float
    expect(dailyweather.min_temp).to be_a Float
    expect(dailyweather.condition).to be_a String
    expect(dailyweather.icon).to be_a String
  end
end