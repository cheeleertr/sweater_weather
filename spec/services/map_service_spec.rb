require 'rails_helper'

describe MapService do
  context "class methods" do
    context "#get_coordinates_by_location" do
      it "returns coordinates data", :vcr do
        search = MapService.get_coordinates_by_location("Denver, CO")

        expect(search).to be_a Hash

        coordinates_data = search[:results][0][:locations][0][:latLng]

        expect(coordinates_data).to be_a Hash
        
        expect(coordinates_data).to have_key(:lat)
        expect(coordinates_data[:lat]).to be_a Float

        expect(coordinates_data).to have_key(:lng)
        expect(coordinates_data[:lng]).to be_a Float
      end

      it "returns fallback coordinates when no results found", :vcr do
        search = MapService.get_coordinates_by_location("notreallyacity,notreallyastate")

        expect(search).to be_a Hash

        coordinates_data = search[:results][0][:locations][0][:latLng]

        expect(coordinates_data).to be_a Hash
        
        expect(coordinates_data).to have_key(:lat)
        expect(coordinates_data[:lat]).to eq(38.89037)

        expect(coordinates_data).to have_key(:lng)
        expect(coordinates_data[:lng]).to eq(-77.03196)
      end
    end
  end
end