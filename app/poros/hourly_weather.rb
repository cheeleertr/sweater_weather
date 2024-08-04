class HourlyWeather
  attr_reader :time, :temperature, :condition, :icon

  def initialize(data)
    @time = data[:time]
    @temperature = data[:temp_c]
    @condition = data[:condition][:text]
    @icon = data[:condition][:icon]
  end
end