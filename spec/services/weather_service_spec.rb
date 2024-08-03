require 'rails_helper'

describe WeatherService do
  context "class methods" do
    context "#get_forecast_location" do
      it "returns forecast data", :vcr do
        forecast_data = WeatherService.get_forecast_by_coordinates("39.74001", "-104.99202")

        expect(forecast_data).to be_a Hash
        
        expect(forecast_data).to have_key(:location)

        location = forecast_data[:location]

        expect(location).to be_a Hash
        expect(location).to have_key(:name)
        expect(location[:name]).to be_a String

        expect(location).to have_key(:region)
        expect(location[:region]).to be_a String

        expect(location).to have_key(:lat)
        expect(location[:lat]).to be_a Float

        expect(location).to have_key(:lon)
        expect(location[:lon]).to be_a Float

        expect(forecast_data).to have_key(:current)

        current = forecast_data[:current]

        expect(current).to be_a Hash
        expect(current).to have_key(:last_updated)
        expect(current[:last_updated]).to be_a String

        expect(current).to have_key(:temp_f)
        expect(current[:temp_f]).to be_a Float

        expect(current).to have_key(:feelslike_f)
        expect(current[:feelslike_f]).to be_a Float

        expect(current).to have_key(:humidity)
        expect(current[:humidity]).to be_a Integer

        expect(current).to have_key(:uv)
        expect(current[:uv]).to be_a Float

        expect(current).to have_key(:vis_miles)
        expect(current[:vis_miles]).to be_a Float

        expect(current).to have_key(:condition)
        expect(current[:condition]).to be_a Hash

        expect(current[:condition]).to have_key(:text)
        expect(current[:condition][:text]).to be_a String

        expect(current[:condition]).to have_key(:icon)
        expect(current[:condition][:icon]).to be_a String

        forecast_days = forecast_data[:forecast][:forecastday]

        expect(forecast_days).to be_an Array
        expect(forecast_days.count == 5).to be(true)

        forecast_days.each do |forecast_day|
          expect(forecast_day).to have_key(:date)
          expect(forecast_day[:date]).to be_a String

          expect(forecast_day[:day]).to have_key(:maxtemp_f)
          expect(forecast_day[:day][:maxtemp_f]).to be_a Float

          expect(forecast_day[:day]).to have_key(:mintemp_f)
          expect(forecast_day[:day][:mintemp_f]).to be_a Float

          expect(forecast_day[:day]).to have_key(:condition)
          expect(forecast_day[:day][:condition]).to be_a Hash

          expect(forecast_day[:day][:condition]).to have_key(:text)
          expect(forecast_day[:day][:condition][:text]).to be_a String

          expect(forecast_day[:day][:condition]).to have_key(:icon)
          expect(forecast_day[:day][:condition][:icon]).to be_a String


          expect(forecast_day[:astro]).to have_key(:sunrise)
          expect(forecast_day[:astro][:sunrise]).to be_a String

          expect(forecast_day[:astro]).to have_key(:sunset)
          expect(forecast_day[:astro][:sunset]).to be_a String

          hours = forecast_day[:hour]

          expect(hours).to be_an Array
          expect(hours.count == 24).to eq(true)

          hours.each do |hour|
            expect(hour).to have_key(:time)
            expect(hour[:time]).to be_a String

            expect(hour).to have_key(:temp_f)
            expect(hour[:temp_f]).to be_a Float

            expect(hour).to have_key(:condition)
            expect(hour[:condition]).to be_a Hash
  
            expect(hour[:condition]).to have_key(:text)
            expect(hour[:condition][:text]).to be_a String
  
            expect(hour[:condition]).to have_key(:icon)
            expect(hour[:condition][:icon]).to be_a String
          end
        end
      end

      it "returns error message when no location found" do
        forecast_data = WeatherService.get_forecast_by_coordinates("notreallyaplace", "notreallyaplace")

        expect(forecast_data).to be_a Hash
        
        expect(forecast_data).to have_key(:error)

        expect(forecast_data).to be_a Hash
        expect(forecast_data[:error]).to have_key(:message)
        expect(forecast_data[:error][:message]).to eq("No matching location found.")
      end

    end
  end
end