require "rails_helper"

RSpec.describe "Create New User Page", type: :feature do
  describe "As a user" do
    before do
      @user = User.create!(name: 'Tommy', email: 'tommy@email.com', password: 'password_1', password_confirmation: 'password_1')
      @user = User.create!(name: 'Sam', email: 'sam@email.com', password: 'password_2', password_confirmation: 'password_2')

      visit register_user_path
    end

    describe "displays link" do
      it "'Home' that redirects to landing page" do
        expect(page).to have_link('Home')

        click_link "Home"

        expect(current_path).to eq(root_path)
      end
    end

    describe "displays form to register new user" do
      it "with user name, email, password, and password confirmation fields" do
        expect(page).to have_field("user[name]")
        expect(page).to have_field('user[email]')
        expect(page).to have_field(:user_password)
        expect(page).to have_field(:user_password_confirmation)
        expect(page).to have_selector(:link_or_button, 'Create New User')    
      end
    end

    describe "submitting form to register new user" do
      it "redirects to user's dashboard page '/users/:id'" do
        fill_in "user[name]", with: 'Chris'
        fill_in "user[email]", with: 'chris@email.com'
        fill_in :user_password, with: 'password_3'
        fill_in :user_password_confirmation , with: 'password_3'

        click_button 'Create New User'

        new_user = User.last

        expect(current_path).to eq(user_path(new_user))
        expect(page).to have_content('Successfully Created New User')
      end
      
      it "requires all fields to be completed" do
        click_button 'Create New User'

        expect(current_path).to eq(register_user_path)
        expect(page).to have_content("Name can't be blank, Email can't be blank, Password can't be blank, Password confirmation can't be blank, Email is invalid, Password confirmation doesn't match Password")
      end
  
      describe "requires email" do
        it "to be unique" do
          fill_in "user[name]", with: 'Tommy'
          fill_in "user[email]", with: 'tommy@email.com'
    
          click_button 'Create New User'
    
          expect(current_path).to eq(register_user_path)
          expect(page).to have_content('Email has already been taken')
        end
    
        it "to have valid format" do 
          fill_in "user[name]", with: "Sam"
          fill_in "user[email]", with: "sam sam@email.co.uk"
    
          click_button 'Create New User'
    
          expect(current_path).to eq(register_user_path)
          expect(page).to have_content('Email is invalid')
    
          fill_in "user[name]", with: "Sammy"
          fill_in "user[email]", with: "sam@email..com"
          click_button 'Create New User'
    
          expect(current_path).to eq(register_user_path)
          expect(page).to have_content('Email is invalid')
    
          fill_in "user[name]", with: "Sammy"
          fill_in "user[email]", with: "sam@emailcom."
          click_button 'Create New User'
    
          expect(current_path).to eq(register_user_path)
          expect(page).to have_content('Email is invalid')
    
          fill_in "user[name]", with: "Sammy"
          fill_in "user[email]", with: "sam@emailcom@"
          click_button 'Create New User'
    
          expect(current_path).to eq(register_user_path)
          expect(page).to have_content('Email is invalid')
        end
      end

      describe "requires password" do
        it "to match password confirmation" do
          fill_in "user[name]", with: 'Chris'
          fill_in "user[email]", with: 'chris@email.com'
          fill_in :user_password, with: 'password_3'
          fill_in :user_password_confirmation , with: 'password_4'
          click_button 'Create New User'

          expect(current_path).to eq(register_user_path)
          expect(page).to have_content("Password confirmation doesn't match Password")
        end
      end
    end
  end
end