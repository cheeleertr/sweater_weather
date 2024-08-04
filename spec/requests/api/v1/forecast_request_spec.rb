require 'rails_helper'

describe "Forecast API" do
  it "returns forecast JSON data with the correct structure and values" do

    get '/api/v1/forecast?location=cincinatti,oh'


    expect(response).to be_successful
    expect(response.status).to eq(200)
    
    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to be_a(Hash)

    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to be_nil

    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq("forecast")

    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a(Hash)

    expect(forecast[:data][:attributes]).to have_key(:current_weather)

    current_weather = forecast[:data][:attributes][:current_weather]

    expect(current_weather).to be_a(Hash)
    expect(current_weather).to have_key(:last_updated)
    expect(current_weather[:last_updated]).to be_a(String)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_a(Integer)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather[:uvi]).to be_a(Float)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_a(Float)
    expect(current_weather).to have_key(:condition)
    expect(current_weather[:condition]).to be_a(String)
    expect(current_weather).to have_key(:icon)
    expect(current_weather[:icon]).to be_a(String)

    expect(forecast[:data][:attributes]).to have_key(:daily_weather)

    daily_weather = forecast[:data][:attributes][:daily_weather]

    expect(daily_weather).to be_an(Array)
    expect(daily_weather.count).to eq(5)

    daily_weather.each do |day|
      expect(day).to be_a(Hash)
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a(String)
      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a(String)
      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a(String)
      expect(day).to have_key(:max_temp)
      expect(day[:max_temp]).to be_a(Float)
      expect(day).to have_key(:min_temp)
      expect(day[:min_temp]).to be_a(Float)
      expect(day).to have_key(:condition)
      expect(day[:condition]).to be_a(String)
      expect(day).to have_key(:icon)
      expect(day[:icon]).to be_a(String)
    end

    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)

    hourly_weather = forecast[:data][:attributes][:hourly_weather]

    expect(hourly_weather).to be_an(Array)
    expect(hourly_weather.count).to eq(24)

    hourly_weather.each do |hour|
      expect(hour).to be_a(Hash)
      expect(hour).to have_key(:time)
      expect(hour[:time]).to be_a(String)
      expect(hour).to have_key(:temperature)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour).to have_key(:condition)
      expect(hour[:condition]).to be_a(String)
      expect(hour).to have_key(:icon)
      expect(hour[:icon]).to be_a(String)
    end
  end
end