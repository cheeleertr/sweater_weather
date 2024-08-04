require 'rails_helper'

describe SweaterWeatherFacade do
  context "class methods" do
    context "#get_forecast_by_location" do
      it "returns forecast data", :vcr do
        response = SweaterWeatherFacade.new.get_forecast_by_location("Denver,CO")

        expect(response).to be_a Forecast
      end

      it "can gracefully handle if the location is invalid" do

      end
    end
  end
end