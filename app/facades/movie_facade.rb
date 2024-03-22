class MovieFacade
  def self.movie_results(search_param)
    if search_param == "top_rated"
      json = MovieService.top_rated_movies

      json[:results].take(20).map do |result_data|
        MovieResult.new(result_data)
      end
    else #search_param == keyword
      json = MovieService.search_for_movie(search_param)

      json[:results].take(20).map do |result_data|
        MovieResult.new(result_data)
      end
    end
  end

  def self.movie(movie_id)
    json = MovieService.movie_details(movie_id)

    Movie.new(json)
  end

  def self.cast_members(movie_id)
    json = MovieService.cast_members(movie_id)

    json[:cast].take(10).map do |cast_member_info| 
      CastMember.new(cast_member_info)
    end
  end

  def self.reviews(movie_id)
    json = MovieService.reviews(movie_id)

    json[:results].map do |review_data| 
      MovieReview.new(review_data)
    end
  end
end