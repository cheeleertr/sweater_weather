require 'rails_helper'

describe "Users API" do
  context "post /api/v1/users" do
    it "creates a user and returns JSON data with the correct structure and values", :vcr do
      user_attributes = {
        email: "testinguserscreate@gmail.com",
        password: "password",
        password_confirmation: "password"
      }

      post '/api/v1/users', params: user_attributes.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(201)

      user_response = JSON.parse(response.body, symbolize_names: true)

      expect(user_response).to have_key(:data)
      expect(user_response[:data]).to be_a(Hash)

      expect(user_response[:data]).to have_key(:id)
      expect(user_response[:data][:id]).to be_a(Integer)

      expect(user_response[:data]).to have_key(:type)
      expect(user_response[:data][:type]).to eq("users")

      expect(user_response[:data]).to have_key(:attributes)
      expect(user_response[:data][:attributes]).to be_a(Hash)

      expect(user_response[:data][:attributes]).to have_key(:email)
      expect(user_response[:data][:attributes][:email]).to eq(user_attributes[:email])

      expect(user_response[:data][:attributes]).to have_key(:api_key)
      expect(user_response[:data][:attributes][:api_key]).to be_a(String)
    end

    it "returns a 422 status code and errors when the request is invalid", :vcr do
      User.create!(email: 'existinguser@gmail.com', password: 'password', password_confirmation: 'password')

      invalid_attributes = [
        { email: '', password: 'password', password_confirmation: 'password' },
        { email: 'testinguserscreate@gmail.com', password: '', password_confirmation: 'password' },
        { email: 'testinguserscreate@gmail.com', password: 'password', password_confirmation: 'mismatch' },
        { email: 'existinguser@gmail.com', password: 'password', password_confirmation: 'password' }
      ]

      invalid_attributes.each do |attributes|
        post '/api/v1/users', params: attributes.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to_not be_successful
        expect(response.status).to eq(422)
        error_response = JSON.parse(response.body, symbolize_names: true)

        expect(error_response).to have_key(:errors)
        expect(error_response[:errors].first).to have_key(:status)
        expect(error_response[:errors].first).to have_key(:title)
      end
    end
  end
end