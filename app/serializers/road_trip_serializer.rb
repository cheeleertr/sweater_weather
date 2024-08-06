class RoadTripSerializer
  include JSONAPI::Serializer

  def self.format_road_trip(road_trip, from, to)
    {
    "data": {
        "id": nil,
        "type": "road_trip",
        "attributes": {
            "start_city": from,
            "end_city": to,
            "travel_time": road_trip.travel_time,
            "weather_at_eta": {
                "datetime": road_trip.eta,
                "temperature": road_trip.temperature,
                "condition": road_trip.condition
                }
            }
        }
    }
  end

  def self.format_impossible_trip(from, to)
    {
      "data": {
          "id": nil,
          "type": "road_trip",
          "attributes": {
              "start_city": from,
              "end_city": to,
              "travel_time": "impossible",
              "weather_at_eta": {}
          }
      }
    }
  end
end