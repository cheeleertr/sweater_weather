class Route
  attr_reader :travel_time, :eta_hour, :eta_date

  def initialize(data)
    @travel_time = data[:route][:formattedTime]
    @eta_date = (Time.now + data[:route][:time]).strftime("%Y-%m-%d")
    @eta_hour = (Time.now + data[:route][:time]).strftime("%H")
    # binding.pry
  end
end