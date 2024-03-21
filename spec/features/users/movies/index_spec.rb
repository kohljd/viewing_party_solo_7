require "rails_helper"

RSpec.describe "Movies Index", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

    it "displays button to return to Discover Movies Page" do
      json_response = File.read("spec/fixtures/tmdb_movies_top_rated.json")
        stub_request(:get, "https://api.themoviedb.org/3/discover/movie?include_adult=false&language=en-US&sort_by=vote_average.desc.json").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:api_key]
            }
          ).
          to_return(status: 200, body: json_response)

      visit user_movies_path(user_1, params:{discover: :top_rated})
          
      expect(page).to have_button("Discover Page")
      click_on "Discover Page"
      
      expect(current_path).to eq(user_discover_index_path(user_1))
      expect(page).to have_button("Discover Top Rated Movies")
      expect(page).to have_button("Search by Movie Title")
    end

    it "displays movie titles as links to their Movie Details page" do
      json_response = File.read("spec/fixtures/tmdb_search_by_movie_title.json")
      stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=The%20Phantom").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:api_key]
          }
        ).
        to_return(status: 200, body: json_response)
  
      visit user_movies_path(user_1, params:{keyword: "The Phantom"})
      
      expect(page).to have_link("The Phantom", href: user_movie_path(user_1, id: 9826))
    end
  end
end