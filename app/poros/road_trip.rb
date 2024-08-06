class RoadTrip
  attr_reader :travel_time, :eta, :temperature, :condition

  def initialize(route, weather)
    @travel_time = route.travel_time
    @eta = "#{route.eta_date} #{route.eta_hour}:00"
    @temperature = weather[:forecast][:forecastday][0][:hour][0][:temp_f]
    @condition = weather[:forecast][:forecastday][0][:hour][0][:condition][:text]
  end
end