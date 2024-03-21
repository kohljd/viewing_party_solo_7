require "rails_helper"

RSpec.describe MovieResult do
  it "is a movie with attributes" do
    attributes = {
      title: "Howl's Moving Castle",
      vote_average: 9,
      id: 55
    }

    movie_result = MovieResult.new(attributes)
    
    expect(movie_result).to be_a MovieResult
    expect(movie_result.title).to eq("Howl's Moving Castle")
    expect(movie_result.vote_average).to eq(9)
    expect(movie_result.movie_id).to eq(55)
  end
end