require "rails_helper"

RSpec.describe MovieReview do
  it "is a movie review with attributes" do
    attributes = {
      id: 561958,
      author: "Martin",
      content: "Such a great review"
    }

    movie_review = MovieReview.new(attributes)
    
    expect(movie_review).to be_a MovieReview
    expect(movie_review.review_id).to eq(561958)
    expect(movie_review.author).to eq("Martin")
    expect(movie_review.content).to eq("Such a great review")
  end
end