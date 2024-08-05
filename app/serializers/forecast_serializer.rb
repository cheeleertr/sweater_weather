class ForecastSerializer
  include JSONAPI::Serializer

  def self.format_forecast(forecast)
    {
    data: {
      id: nil,
      type: "forecast",
      attributes: {
        current_weather: {
          last_updated: forecast.current_weather.last_updated,
          temperature: forecast.current_weather.temperature,
          feels_like: forecast.current_weather.feels_like,
          humidity: forecast.current_weather.humidity,
          uvi: forecast.current_weather.uvi,
          visibility: forecast.current_weather.visibility,
          condition: forecast.current_weather.condition,
          icon: forecast.current_weather.icon
        },
        daily_weather: 
          forecast.daily_weather.map do |daily_weather|
            {
              date: daily_weather.date,
              sunrise: daily_weather.sunrise,
              sunset: daily_weather.sunset,
              max_temp: daily_weather.max_temp,
              min_temp: daily_weather.min_temp,
              condition: daily_weather.condition,
              icon: daily_weather.icon
            }
          end,
        hourly_weather:
          forecast.hourly_weather.map do |hourly_weather|
            {
              time: DateTime.parse(hourly_weather.time).strftime("%H:%M"),
              temperature: hourly_weather.temperature,
              condition: hourly_weather.condition,
              icon: hourly_weather.icon
            }
          end
        }
      }
    }
  end
end