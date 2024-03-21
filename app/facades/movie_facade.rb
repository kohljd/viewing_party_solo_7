class MovieFacade
  def self.movie(movie_id)
    service = MovieService.new
    json = service.movie_details(movie_id)
    @movie = Movie.new(json)
  end

  def self.cast_members(movie_id)
    service = MovieService.new
    json = service.cast_members(movie_id)
    @cast_members = json[:cast].take(10).map {|cast_member_info| CastMember.new(cast_member_info)}
  end

  def self.reviews(movie_id)
    service = MovieService.new
    json = service.reviews(movie_id)
    @reviews = json[:results].map {|review_data| MovieReview.new(review_data)}
  end
end