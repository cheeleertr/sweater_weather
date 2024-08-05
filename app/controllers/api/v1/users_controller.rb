class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user.api_keys.create!(token: SecureRandom.hex)
      render json: UserSerializer.format_user(user), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new(user.errors.full_messages, 422)).serialize_json, status: :unprocessable_entity
    end
  end

private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end