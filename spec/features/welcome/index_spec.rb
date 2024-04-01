require 'rails_helper'

RSpec.describe 'Root Page, Welcome Index', type: :feature do
  describe "As a user" do
    before do
      @user_1 = User.create!(name: 'Sam', email: 'sam_t@email.com', password: "password_1", password_confirmation: "password_1")
      @user_2 = User.create!(name: 'Tommy', email: 'tommy_t@gmail.com', password: "password_1", password_confirmation: "password_1")

      visit root_path
    end

    it "displays application title" do
      expect(page).to have_content('Viewing Party')
    end

    describe "displays button/link" do
      it " to home page" do
        expect(page).to have_link('Home')
      end
  
      it "to Create New User" do
        expect(page).to have_button("Create New User")
        click_button "Create New User"
        expect(current_path).to eq(register_user_path)
      end

      it "to Sign In user" do
        expect(page).to have_button("Sign In")
        click_button "Sign In"
        expect(current_path).to eq(login_path)
      end
    end

    it "lists existing users, with links to each individual user's dashboard" do
      within("#existing_users") do 
        expect(page).to have_content(User.first.email)
        expect(page).to have_content(User.last.email)
        expect(page).to have_link("#{User.first.email}", href: "users/#{User.first.id}")
        expect(page).to have_link("#{User.last.email}", href: "users/#{User.last.id}")
      end
    end

    it "They see a link to go back to the landing page (present at the top of all pages)" do
      expect(page).to have_link("Home")
    end
  end
end
