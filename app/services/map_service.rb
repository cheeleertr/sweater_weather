class MapService
  def self.conn
    Faraday.new(url: "http://www.mapquestapi.com") do |faraday|
      faraday.params[:key] = Rails.application.credentials.mapquest[:key]
    end
  end

  def self.get_coordinates_by_location(location)
    response = conn.get("/geocoding/v1/address?location=#{location}")
    JSON.parse(response.body, symbolize_names: true)
  end
end