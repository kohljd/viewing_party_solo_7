class MoviesController < ApplicationController
  before_action :find_user, only: [:index, :show]

  def index
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:api_key]
    end

    if params[:discover]
      response = conn.get("/3/movie/top_rated")
      data = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      @movie_results = data[:results].take(20).map {|result_attributes| MovieResult.new(result_attributes)}
    elsif params[:keyword] != ""
      response = conn.get("/3/search/movie?query=#{params[:keyword]}")
      data = JSON.parse(response.body, symbolize_names: true)
      @movie_results = data[:results].take(20).map {|result_attributes| MovieResult.new(result_attributes)}
    else #params[:keyword].blank?
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