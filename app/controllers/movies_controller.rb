class MoviesController < ApplicationController
  before_action :find_user, only: [:index]
  # before_action :find_user_and_movie, only: [:show]

  def index
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:api_key]
    end

    if params[:keyword]
      response = conn.get("/3/search/movie?query=#{params[:keyword]}")
      data = JSON.parse(response.body, symbolize_names: true)
      @movie_results = data[:results].take(20).map {|result_attributes| MovieResult.new(result_attributes)}
    else #top rated movies
      response = conn.get("/3/discover/movie?include_adult=false&language=en-US&sort_by=vote_average.desc.json")
      data = JSON.parse(response.body, symbolize_names: true)
      @movie_results = data[:results].take(20).map {|result_attributes| MovieResult.new(result_attributes)}
    end
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end

  # def find_user_and_movie
  #   find_user
  #   @movie = Movie.find(params[:movie_id])
  # end
end