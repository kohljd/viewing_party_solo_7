require "rails_helper"

RSpec.describe "User's Discover Page", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com")}

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

    descibe "Discover Top Rate Movies button" do
      it "redirects to Movies Index which displays up to 20 top rated movies" do
        click_button "Discover Top Rated Movies"
        expect(current_path).to eq(user_movies_path(user_1))
        expect(page).to have_content("Vote Average:", count: 20)
      end
    end

    describe "Search by Movie Title" do
      it "redirects to Movies Index which displays up to 20 movies w/the matching title keyword(s)" do
        fill_in :keyword, with: "All Dogs"
        click_button "Search by Movie Title"
        expect(current_path).to eq(user_movies_path(user_1))
        # expect(page).to have_content()
      end

      it "can't redirect if no keyword entered" do
        click_button "Search by Movie Title"
        expect(current_path).to eq(user_discover_index_path(user_1))
      end
    end
  end
end