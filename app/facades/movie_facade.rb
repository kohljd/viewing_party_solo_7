class MovieFacade
  def initialize(movie_id)
    @movie_id = movie_id
  end

  def movie
    service = MovieService.new
    json = service.movie_details(@movie_id)
    @movie = Movie.new(json)
  end

  def cast_members
    service = MovieService.new
    json = service.cast_members(@movie_id)
    @cast_members = json[:cast].take(10).map {|cast_member_info| CastMember.new(cast_member_info)}
  end

  def reviews
    service = MovieService.new
    json = service.reviews(@movie_id)
    @reviews = json[:results].map {|review_data| MovieReview.new(review_data)}
  end
end