require "rails_helper"

RSpec.describe "Login Page", type: :feature do
  describe "As a user" do
    before do
      visit login_path
    end

    it "displays sign in form to enter user credentials" do
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_button("Sign In")
    end

    describe "signing in" do
      it "requires all fields to be completed" do
        click_button "Sign In"
        expect(page).to have_content("Invalid Credentials")
      end

      it "requires valid user email" do
        user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'password_1', password_confirmation: 'password_1')
        visit login_path
        fill_in :email, with: 'tommy_257@email.com'
        fill_in :password, with: 'password_1'
        click_button "Sign In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Invalid Credentials")
      end

      it "requires valid user password" do
        user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'password_1', password_confirmation: 'password_1')
        visit login_path
        fill_in :email, with: 'tommy@email.com'
        fill_in :password, with: 'password_2'
        click_button "Sign In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Invalid Credentials")
      end

      it "redirects to user's dashboard if credentials valid" do
        user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'password_1', password_confirmation: 'password_1')
        visit login_path
        fill_in :email, with: 'tommy@email.com'
        fill_in :password, with: 'password_1'
        click_button "Sign In"

        expect(current_path).to eq(user_path(user))
      end
    end
  end
end