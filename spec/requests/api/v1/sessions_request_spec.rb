require 'rails_helper'

describe "Sessions API" do
  context "post /api/v1/sessions" do
    before do
      @user = User.create!(
        email: "testsession@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      @user.api_keys.create!(token: "t1h2i3s4_i5s6_l7e8g9i10t11")
    end

    it "returns user API key with correct email and password" do
      user_attributes = {
        email: "whatever@gmail.com",
        password: "password"
      }

      post '/api/v1/sessions', params: user_attributes.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

      expect(response).to be_successful
      expect(response).to eq(201)

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_a(Hash)

      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data][:id]).to eq(@user.id.to_s)

      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data][:type]).to eq("users")

      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:attributes]).to be_a(Hash)

      expect(response_body[:data][:attributes]).to have_key(:email)
      expect(response_body[:data][:attributes][:email]).to eq(@user.email)

      expect(response_body[:data][:attributes]).to have_key(:api_key)
      expect(response_body[:data][:attributes][:api_key]).to eq("t1h2i3s4_i5s6_l7e8g9i10t11")
    end

    it "returns a 401 status code and errors when the request is invalid" do
      invalid_credentials = [
        { email: '', password: 'password' },
        { email: 'testsession@gmail.com', password: '' },
        { email: 'wrong@gmail.com', password: 'password' },
        { email: 'testsession@gmail.com', password: 'wrongpassword' }
      ]

      invalid_credentials.each do |credentials|
        post '/api/v1/sessions', params: credentials.to_json, headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' }

        expect(response).to_not be_successful
        expect(response).to eq(401)
        expect(response.body[:errors].first[:title]).to eq('Invalid credentials')
      end
    end
  end
end