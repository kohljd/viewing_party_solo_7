class ViewingPartyController < ApplicationController
  before_action :find_user_and_movie

  def new; end

  private
  def find_user_and_movie
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie(params[:movie_id])
  end
end