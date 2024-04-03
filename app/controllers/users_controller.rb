class UsersController < ApplicationController
  before_action :signed_in?, only: :show
   def new
      @user = User.new
   end

   def show
      @user = User.find(params[:id])
   end

   def create
      user = User.new(user_params)
      if user.save
         session[:user_id] = user.id
         flash[:success] = 'Successfully Created New User'
         redirect_to user_path(user)
      else
         flash[:error] = "#{error_message(user.errors)}"
         redirect_to register_user_path
      end
   end

private

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def signed_in?
    redirect_to root_path unless current_user.present?
    flash[:alert] = "Must be logged in or registered to access a user's dashboard"
  end
end