class MovieResult
  attr_reader :title,
              :vote_average,
              :movie_id

  def initialize(attributes)
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @movie_id = attributes[:id]
  end
end