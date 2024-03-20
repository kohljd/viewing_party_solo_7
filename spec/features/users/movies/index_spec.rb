require "rails_helper"

RSpec.describe "Movies Index", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

    before do
      visit user_movies_path(user_1)
    end

    it "displays button to return to Discover Movies Page" do
      expect(page).to have_button("Discover Page")
      click_on "Discover Page"
      
      expect(current_path).to eq(user_discover_index_path(user_1))
      expect(page).to have_button("Discover Top Rated Movies")
      expect(page).to have_button("Search by Movie Title")
    end
  end
end