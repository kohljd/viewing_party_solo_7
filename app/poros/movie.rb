class Movie
  attr_reader :movie_id,
              :title,
              :vote_average,
              :runtime,
              :genres,
              :summary

  def initialize(attributes)
    @movie_id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @summary = attributes[:overview]
  end

  def format_runtime
    hours = @runtime.to_i / 60
    minutes = @runtime.to_i % 60
    "#{hours}hr #{minutes}min"
  end

  def list_genres
    @genres.map {|genre| genre[:name]}.join(", ")
  end
end