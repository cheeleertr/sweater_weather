class WeatherService
  def self.conn
    Faraday.new(url: "http://api.weatherapi.com") do |faraday|
      faraday.params[:key] = Rails.application.credentials.weather[:key]
    end
  end

  def self.get_forecast_by_coordinates(lat,lon)
    response = conn.get("/v1/forecast.json?q=#{lat},#{lon}&days=5&aqi=no&alerts=no")
    JSON.parse(response.body, symbolize_names: true)
  end
end