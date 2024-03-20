require "rails_helper"

RSpec.describe "Movie Details Page", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

    describe "displays button" do
      before do
        json_response = File.read("spec/fixtures/tmdb_movie_details.json")
        stub_request(:get, "https://api.themoviedb.org/3/movie/546554").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:api_key]
            }
          ).
          to_return(status: 200, body: json_response)
          
        visit user_movie_path(user_1, id: 546554)
      end

      it "to return to Discover Page" do
        expect(page).to have_button("Discover Page")
        click_on "Discover Page"
        
        expect(current_path).to eq(user_discover_index_path(user_1))
        expect(page).to have_button("Discover Top Rated Movies")
        expect(page).to have_button("Search by Movie Title")
      end

      it "to create a Viewing Party" do
        expect(page).to have_button("Create Viewing Party for Knives Out")
        # click_on "Create Viewing Party for #{movie_1.title}"
        
        # expect(current_path).to eq(user_discover_index_path(user_1))
      end
    end

    describe "displays movie's details" do
      before do
        json_response = File.read("spec/fixtures/tmdb_movie_details.json")
        stub_request(:get, "https://api.themoviedb.org/3/movie/546554").
          with(
            query: {
              "api_key" => Rails.application.credentials.tmdb[:api_key]
            }
          ).
          to_return(status: 200, body: json_response)

        visit user_movie_path(user_1,id: 546554)
      end

      it "title" do
        save_and_open_page
        expect(page).to have_content("Knives Out")
      end

      it "vote average" do
        expect(page).to have_content("Vote: 7.8")
      end

      it "runtime in hours & minutes" do
        expect(page).to have_content("Runtime: 2hr 11min")
      end

      it "associated genre(s)" do
        expect(page).to have_content("Genre(s): Comedy, Crime, Mystery")
      end

      it "plot summary" do
        expect(page).to have_content("Summary")
        expect(page).to have_content(body.summary)
      end
    end

    describe "displays movie's cast" do
      # before do
      #   # webmock things
      #   visit user_movie_path(user_1, movie_1)
      # end

      xit "lists the first 10 cast members" do

      end

      xit "lists cast member's name and their character's name" do

      end
    end

    describe "displays movie's reviews" do
      # before do
      #   # webmock things
      #   visit user_movie_path(user_1, movie_1)
      # end
      
      xit "total review count" do

      end

      xit "with each review's information" do

      end

      xit "with each review's author" do

      end
    end
  end
end