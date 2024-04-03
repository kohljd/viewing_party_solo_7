class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:user_location] = {
        value: params[:location],
        expires: 8.hours.from_now
      }
      redirect_to user_path(user)
      flash[:success] = "Welcome back, #{user.email}!"
    else
      redirect_to '/login'
      flash[:error] = 'Invalid Credentials'
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end