class ViewingPartyController < ApplicationController
  before_action :find_user_and_movie

  def new; end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      
      redirect_to user_path(@user)
    else
      flash[:alert] = viewing_party.errors.full_messages
    end
  end

  private
  def find_user_and_movie
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie(params[:movie_id])
  end

  def viewing_party_params
    params.require(:viewing_party).permit(:duration, :date, :start_time, :movie_id)
  end

  def user_parties_params
    params.require(:user_party).permit(:user_ids)
  end
end