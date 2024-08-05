require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe "relationships" do
    it {should belong_to :bearer}
  end

  it "can initialize with api key attributes" do
    user = User.create!(
      email: "testuser@example.com",
      password: "password",
      password_confirmation: "password")
    api_key = ApiKey.create!(bearer: user, token: "sample_token")

    expect(api_key.bearer).to eq(user)
    expect(api_key.bearer_type).to eq("User")
    expect(api_key.token).to eq("sample_token")
  end
end