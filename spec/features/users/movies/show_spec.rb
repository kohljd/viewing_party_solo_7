require "rails_helper"

RSpec.describe "Movie Details Page", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com", password: "password_1", password_confirmation: "password_1")}

    before do
      json_response = File.read("spec/fixtures/tmdb_movie_details.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/546554").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:api_key]
          }
        ).
        to_return(status: 200, body: json_response)
    
      json_response_2 = File.read("spec/fixtures/tmdb_movie_credits.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/546554/credits").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:api_key]
          }
        ).
        to_return(status: 200, body: json_response_2)

      json_response_3 = File.read("spec/fixtures/tmdb_movie_reviews.json")
      stub_request(:get, "https://api.themoviedb.org/3/movie/546554/reviews").
        with(
          query: {
            "api_key" => Rails.application.credentials.tmdb[:api_key]
          }
        ).
        to_return(status: 200, body: json_response_3)
        
      visit user_movie_path(user_1, id: 546554)
    end

    describe "displays button" do
      it "to return to Discover Page" do
        expect(page).to have_button("Discover Page")
        click_on "Discover Page"
        
        expect(current_path).to eq(user_discover_index_path(user_1))
        expect(page).to have_button("Discover Top Rated Movies")
        expect(page).to have_button("Search by Movie Title")
      end

      it "to create a Viewing Party" do
        expect(page).to have_button("Create Viewing Party for Knives Out")
      end
    end

    describe "displays movie's details" do
      it "title" do
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
        expect(page).to have_content("When renowned crime novelist Harlan Thrombey is found dead at his estate just after his 85th birthday, the inquisitive and debonair Detective Benoit Blanc is mysteriously enlisted to investigate. From Harlan's dysfunctional family to his devoted staff, Blanc sifts through a web of red herrings and self-serving lies to uncover the truth behind Harlan's untimely death.")
      end
    end

    describe "displays movie's cast" do
      it "lists the first 10 cast members" do
        expect(page).to have_css(".cast_member", count: 10)
      end

      it "lists cast member's name and their character's name" do
        within ".movie_cast" do
          expect(page).to have_content("Daniel Craig")
          expect(page).to have_content("Benoit Blanc")

          expect(page).to have_content("Chris Evans")
          expect(page).to have_content("Ransom Drysdale")

          expect(page).to have_content("Ana de Armas")
          expect(page).to have_content("Marta Cabrera")

          expect(page).to have_content("Jamie Lee Curtis")
          expect(page).to have_content("Linda Drysdale")

          expect(page).to have_content("Michael Shannon")
          expect(page).to have_content("Walt Thrombey")
          
          expect(page).to have_content("Don Johnson")
          expect(page).to have_content("Richard Drysdale")

          expect(page).to have_content("Toni Collette")
          expect(page).to have_content("Joni Thrombey")

          expect(page).to have_content("LaKeith Stanfield")
          expect(page).to have_content("Lieutenant Elliott")

          expect(page).to have_content("Christopher Plummer")
          expect(page).to have_content("Harlan Thrombey")

          expect(page).to have_content("Katherine Langford")
          expect(page).to have_content("Meg Thrombey")
        end
      end
    end

    describe "displays movie's reviews" do      
      it "total review count" do
        expect(page).to have_content("15 Reviews")
      end

      it "with each review's information" do
        expect(page).to have_css(".movie_review", count: 15)

        within ".movie_review", match: :first do
          expect(page).to have_content("SWITCH.")
          expect(page).to have_content("November 25th, 2019")
          expect(find(:css, ".review_content").text).to start_with("This is a crime thriller that’s been a long time in the making.")
          expect(find(:css, ".review_rating").text).to have_content("9.0")
        end
      end

      it "with each review's author" do
        expect(page).to have_css(".review_author", count: 15)
        expect(find(:css, ".review_author", match: :first).text).to eq("SWITCH.")
      end
    end
  end
end