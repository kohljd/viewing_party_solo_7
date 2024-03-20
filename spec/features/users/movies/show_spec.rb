require "rails_helper"

RSpec.describe "Movie Details Page", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

    before do
      visit user_movies_path(user_1, movie_1)
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
        expect(page).to have_button("Create Viewing Party for #{movie_1.title}")
        click_on "Create Viewing Party for #{movie_1.title}"
        
        expect(current_path).to eq(user_discover_index_path(user_1))
      end
    end

    describe "displays movie's details" do
      it "title" do
        expect(page).to have_content()
      end

      it "vote average" do
        expect(page).to have_content("Vote: __")
      end

      it "runtime in hours & minutes" do
        expect(page).to have_content("Runtime: hr min")
      end

      it "associated genre(s)" do
        expect(page).to have_content("Genre: Action, Comedy")
      end

      it "plot summary" do
        expect(page).to have_content("Summary")
        expect(page).to have_content(movie_1.summary)
      end
    end

    describe "displays movie's cast" do
      xit "lists the first 10 cast members" do

      end

      xit "lists cast member's name and their character's name" do

      end
    end

    describe "displays movie's reviews" do
      xit "total review count" do

      end

      xit "with each review's information" do

      end

      xit "with each review's author" do

      end
    end
  end
end