class MoviesController < ApplicationController
  before_action :find_user, only: [:index, :show]

  def index
    if params[:keyword].present?
      @movie_results = MovieFacade.movie_results(params[:keyword])
    else
      flash[:error] = "Please fill out the search box"
      redirect_to user_discover_index_path(@user)
    end
  end

  def show
    movie_id = params[:id]

    @movie = MovieFacade.movie(movie_id)
    @cast_members = MovieFacade.cast_members(movie_id)
    @reviews = MovieFacade.reviews(movie_id)
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end
end