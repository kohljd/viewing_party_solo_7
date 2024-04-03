require "rails_helper"

RSpec.describe "Current Login Session", type: :feature do
  describe "As a user" do
    before do
      visit login_path
    end

    it "keeps user logged in if they leave the site and return" do
      user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'password_1', password_confirmation: 'password_1')
      visit login_path
      fill_in :email, with: 'tommy@email.com'
      fill_in :password, with: 'password_1'
      fill_in :location, with: 'Denver, CO'
      click_button "Sign In"

      expect(current_path).to eq(user_path(user))
      visit "https://google.com"
      visit user_path(user)
      expect(page).to have_button("Sign Out")
      expect(page).to have_content("Tommy's Dashboard")
    end
  end
end