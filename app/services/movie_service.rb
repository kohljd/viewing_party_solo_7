class MovieService
  def self.movie_details(movie_id)
    get_url("/3/movie/#{movie_id}")
  end

  def self.cast_members(movie_id)
    get_url("/3/movie/#{movie_id}/credits")
  end

  def self.reviews(movie_id)
    get_url("/3/movie/#{movie_id}/reviews")
  end

  def self.get_url(url)
    response = conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params["api_key"] = Rails.application.credentials.tmdb[:api_key]
    end
  end
end