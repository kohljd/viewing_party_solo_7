class MovieFacade
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