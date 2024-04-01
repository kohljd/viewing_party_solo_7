require "rails_helper"

RSpec.describe "User's Discover Page", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com", password: "password_1", password_confirmation: "password_1")}

    before do
      visit user_discover_index_path(user_1)
    end

    describe "displays" do
      it "Discover Top Rate Movies button" do
        expect(page).to have_button("Discover Top Rated Movies")
      end

      it "text field to search by movie title" do
        expect(page).to have_field(:keyword)
      end

      it "Search by Movie Title button" do
        expect(page).to have_button("Search by Movie Title")
      end
    end

    describe "clicks Discover Top Rate Movies button" do
      it "redirects to Movies Index which displays up to 20 top rated movies" do
        json_response = File.read("spec/fixtures/tmdb_movies_top_rated.json")
        stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:api_key]
            }
          ).
          to_return(status: 200, body: json_response)

        click_button "Discover Top Rated Movies"
        expect(current_path).to eq(user_movies_path(user_1))
        expect(page).to have_content("Vote Average:", count: 20)
      end
    end

    describe "searches by movie title keyword(s)" do
      it "redirects to Movies Index which displays up to 20 movies w/the matching title keyword(s)" do
        json_response = File.read("spec/fixtures/tmdb_search_by_movie_title.json")
        stub_request(:get, "https://api.themoviedb.org/3/search/movie?query=The%20Phantom").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:api_key]
            }
          ).
          to_return(status: 200, body: json_response)

        fill_in :keyword, with: "The Phantom"
        click_button "Search by Movie Title"
        expect(current_path).to eq(user_movies_path(user_1))
        expect(page).to have_content("Phantom", count: 20)
        expect(page).to have_content("Vote Average:", count: 20)
      end

      it "can't redirect if no keyword entered" do
        fill_in :keyword, with: ""
        click_on "Search by Movie Title"
        expect(current_path).to eq(user_discover_index_path(user_1))
        expect(page).to have_content("Please fill out the search box")
      end
    end
  end
end