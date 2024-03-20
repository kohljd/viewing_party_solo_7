require "rails_helper"

RSpec.describe Movie do
  it "is a movie with attributes" do
    attributes = {
      id: 546554,
      title: "Knive's Out",
      vote_average: 7.8,
      runtime: 131,
      genres: [
        {"id": 35,"name": "Comedy"},
        {"id": 80,"name": "Crime"},
        {"id": 9648, "name": "Mystery"}
      ],
      overview: "A fun whodunit movie"
    }

    movie = Movie.new(attributes)
    
    expect(movie).to be_a Movie
    expect(movie.movie_id).to eq(546554)
    expect(movie.title).to eq("Knive's Out")
    expect(movie.vote_average).to eq(7.8)
    expect(movie.runtime).to eq(131)
    expect(movie.genres).to eq([
      {"id": 35,"name": "Comedy"},
      {"id": 80,"name": "Crime"},
      {"id": 9648, "name": "Mystery"}
    ])
    expect(movie.summary).to eq("A fun whodunit movie")
  end

  it "formats the runtime" do
    attributes = {
      id: 546554,
      title: "Knive's Out",
      vote_average: 7.8,
      runtime: 131,
      genres: [
        {"id": 35,"name": "Comedy"},
        {"id": 80,"name": "Crime"},
        {"id": 9648, "name": "Mystery"}
      ],
      overview: "A fun whodunit movie"
    }

    movie = Movie.new(attributes)
    expect(movie.format_runtime).to eq("2hr 11min")
  end

  it "lists movie genre names" do
    attributes = {
      id: 546554,
      title: "Knive's Out",
      vote_average: 7.8,
      runtime: 131,
      genres: [
        {"id": 35,"name": "Comedy"},
        {"id": 80,"name": "Crime"},
        {"id": 9648, "name": "Mystery"}
      ],
      overview: "A fun whodunit movie"
    }

    movie = Movie.new(attributes)
    expect(movie.list_genres).to eq("Comedy, Crime, Mystery")
  end
end