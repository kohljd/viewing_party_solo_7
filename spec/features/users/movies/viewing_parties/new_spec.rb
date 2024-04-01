require "rails_helper"

RSpec.describe "New Viewing Party", type: :feature do
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

      visit new_user_movie_viewing_party_path(user_1, movie_id: 546554)
    end

    describe "displays form to create viewing party" do
      it "with the movie title displayed at the top" do
        expect(page).to have_content("Movie Title Knives Out")
      end
  
      it "with sections for duration, party date, start time, and guests invited" do
        expect(page).to have_field("Duration of Party")
        expect(page).to have_field("Day")
        expect(page).to have_field("Start Time")
        expect(page).to have_content("Invited Users")
      end
    end

    describe "submitting form to create a viewing party" do
      xit "redirects to user's dashboard" do
        click_on "Create Viewing Party"
        expect(current_path).to eq(user_path(user_1))
      end
    end
  end
end