require "rails_helper"

RSpec.describe "New Viewing Party", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

    before do
      visit new_user_movie_viewing_party_path(user_1, movie_id: 546554)
    end

    describe "displays form to create viewing party" do
      it "with the movie title displayed at the top" do
        expect(find(:css, ".party_movie_title").text).to eq("Knives Out")
      end
  
      it "with sections for duration, party date, start time, and guests invited" do
        expect(page).to have_field("Duration")
        expect(page).to have_field("Day")
        expect(page).to have_field("Start Time")
        expect(page).to have_field(:guests, maximum: 3)
      end
    end
  end
end