require 'rails_helper'

describe "Road Trip API" do
  context "get /api/v1/road_trip" do
    before do
      @user = User.create!(
        email: "testroadtrip@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @api_key = @user.api_keys.create!(token: "t1h2i3s4_i5s6_l7e8g9i10t11")
    end

    it "returns road trip JSON data with correct structure and values", :vcr do
      road_trip_params = {
        origin: "New York, NY",
        destination: "Panama City, Panama",
        api_key: "t1h2i3s4_i5s6_l7e8g9i10t11"
      }

      get '/api/v1/road_trip', params: road_trip_params, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to have_key(:data)
      expect(road_trip[:data]).to be_a(Hash)

      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data][:id]).to be_nil

      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data][:type]).to eq("road_trip")

      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:attributes]).to be_a(Hash)

      expect(road_trip[:data][:attributes]).to have_key(:start_city)
      expect(road_trip[:data][:attributes][:start_city]).to eq("New York, NY")

      expect(road_trip[:data][:attributes]).to have_key(:end_city)
      expect(road_trip[:data][:attributes][:end_city]).to eq("Panama City, Panama")

      expect(road_trip[:data][:attributes]).to have_key(:travel_time)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)

      expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)

      weather_at_eta = road_trip[:data][:attributes][:weather_at_eta]

      expect(weather_at_eta).to be_a(Hash)

      expect(weather_at_eta).to have_key(:datetime)
      expect(weather_at_eta[:datetime]).to be_a(String)

      expect(weather_at_eta).to have_key(:temperature)
      expect(weather_at_eta[:temperature]).to be_a(Float)

      expect(weather_at_eta).to have_key(:condition)
      expect(weather_at_eta[:condition]).to be_a(String)
    end

    it "returns a 401 status code when the API key is missing or incorrect" do
      invalid_api_keys = [
        { origin: "New York, NY", destination: "Panama City, Panama", api_key: "" },
        { origin: "New York, NY", destination: "Panama City, Panama", api_key: "invalid_key" },
        { origin: "New York, NY", destination: "Panama City, Panama" }
      ]

      invalid_api_keys.each do |params|
        get '/api/v1/road_trip', params: params, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response.status).to eq(401)
        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response).to have_key(:errors)
        expect(error_response[:errors].first).to have_key(:status)
        expect(error_response[:errors].first).to have_key(:title)
        expect(error_response[:errors].first[:title]).to eq('Invalid Credentials')
      end
    end

    it "returns a successful status with travel_time impossible and empty weather_at_eta for impossible routes", :vcr do
      road_trip_params = {
        origin: "New York, NY",
        destination: "London, UK",
        api_key: "t1h2i3s4_i5s6_l7e8g9i10t11"
      }

      get '/api/v1/road_trip', params: road_trip_params, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip[:data][:attributes][:travel_time]).to eq("impossible")
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_empty
    end
  end
end