class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user.nil?
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid Credentials", 401)).serialize_json, status: :unauthorized
    elsif user.authenticate(session_params[:password])
      render json: UserSerializer.format_user(user), status: :ok
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid Credentials", 401)).serialize_json, status: :unauthorized
    end
  end

  def session_params
    params.permit(:email, :password)
  end
end