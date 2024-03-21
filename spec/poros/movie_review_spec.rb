require "rails_helper"

RSpec.describe MovieReview do
  it "is a movie review with attributes" do
    attributes = {
      id: "5ddbc870aad9c20012c232bd",
      author: "Martin",
      content: "Such a great review",
      author_details: {
        rating: 9.0
      },
      created_at: "2019-11-25T12:26:24.819Z"
    }

    movie_review = MovieReview.new(attributes)
    
    expect(movie_review).to be_a MovieReview
    expect(movie_review.review_id).to eq("5ddbc870aad9c20012c232bd")
    expect(movie_review.author).to eq("Martin")
    expect(movie_review.content).to eq("Such a great review")
    expect(movie_review.movie_rating).to eq(9.0)
    expect(movie_review.created_at).to eq("2019-11-25T12:26:24.819Z")
  end

  it "formats date review created" do
    attributes = {
      id: "5ddbc870aad9c20012c232bd",
      author: "Martin",
      content: "Such a great review",
      author_details: {
        rating: 9.0
      },
      created_at: "2019-11-25T12:26:24.819Z"
    }

    movie_review = MovieReview.new(attributes)

    expect(movie_review.date_written).to eq("November 25th, 2019")
  end
end
