require "rails_helper"

RSpec.describe "User's Discover Page", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

    before do
      visit user_discover_index(user_1)
    end

    describe "displays" do
      it "Discover Top Rate Movies button" do
        expect(page).to have_button("Discover Top Rated Movies")
      end

      it "text field to search by movie title" do
        expect(page).to have_field("Movie Title")
      end

      it "Search by Movie Title button" do
        expect(page).to have_button("Search by Movie Title")
      end
    end
  end
end