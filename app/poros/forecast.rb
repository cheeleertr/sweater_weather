class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather

  def initialize(data)
    # binding.pry
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = data[:forecast][:forecastday].map {|day| DailyWeather.new(day)}
    @hourly_weather = data[:forecast][:forecastday][0][:hour].map {|hour| HourlyWeather.new(hour)}
  end
end