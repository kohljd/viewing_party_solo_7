require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
  describe "As a visitor or user" do
    let!(:user_1) {User.create!(name: 'Tommy', email: 'tommy@email.com', password: "password_1", password_confirmation: "password_1")}
    let!(:user_2) {User.create!(name: 'Sam', email: 'sam_t@email.com', password: "password_2", password_confirmation: "password_2")}

    before do
      visit root_path
    end

    it "displays application title" do
      expect(page).to have_content('Viewing Party')
    end

    describe "displays button/link" do
      it " to home page" do
        expect(page).to have_link('Home')
      end
  
      context "when visitor/signed-out user" do
        it "to Create New User" do
          expect(page).to_not have_button("Sign Out")
          expect(page).to have_button("Create New User")

          click_button "Create New User"

          expect(current_path).to eq(register_user_path)
        end

        it "to Sign In user" do
          expect(page).to_not have_button("Sign Out")
          expect(page).to have_button("Sign In")

          click_button "Sign In"

          expect(current_path).to eq(login_path)
        end
      end

      context "when signed-in user" do
        it "to Sign Out user" do
          log_in_as(user_1)
          visit root_path

          expect(page).to_not have_button("Create New User")
          expect(page).to_not have_button("Sign In")
          expect(page).to have_button("Sign Out")

          click_button "Sign Out"

          expect(current_path).to eq(root_path)
          expect(page).to have_button("Create New User")
          expect(page).to have_button("Sign In")
          expect(page).to_not have_button("Sign Out")
        end
      end
    end

    context "when signed-in user" do
      it "lists existing users" do
        log_in_as(user_1)
        visit root_path
        
        within("#existing_users") do 
          expect(page).to have_content(User.first.email)
          expect(page).to have_content(User.last.email)
        end
      end
    end

    it "They see a link to go back to the landing page (present at the top of all pages)" do
      expect(page).to have_link("Home")
    end

    def log_in_as(user, location = nil)
      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button "Sign In"
    end
  end
end
