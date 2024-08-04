class Api::V1::UsersController < ApplicationController
  def create
    binding.pry
    user = User.new(user_params)
    if user.save
        session[:user_id] = user.id
        flash[:success] = "Welcome, #{user.name}!"
        
    else
      flash[:error] = "#{error_message(user.errors)}"
      
    end
  end

private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end