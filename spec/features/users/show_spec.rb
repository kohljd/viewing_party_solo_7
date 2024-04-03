require "rails_helper"

RSpec.describe "User's Dashboard (Show Page)", type: :feature do
  describe "As a user" do
    let(:user_1) {User.create!(name: "Megan", email: "megan@email.com", password: "password_1", password_confirmation: "password_1")}

    describe "Dashboard heading for current session" do
      context "given user's location at login" do
        it "displays '[User]'s Dashboard' and 'Location:'" do
          log_in_as(user_1, "Morning, Espresso")

          expect(page).to have_content("Megan's Dashboard")
          expect(page).to have_content("Location: Morning, Espresso")
        end
      end

      context "given user's location at a previous login < 8 hours ago" do
        it "displays '[User]'s Dashboard' and 'Location:'" do
          log_in_as(user_1, "Morning, Espresso")
          click_on "Sign Out"

          allow(Time).to receive(:now).and_return(Time.now + 5.hours)
          log_in_as(user_1)

          expect(current_path).to eq(user_path(user_1))
          expect(page).to have_content("Megan's Dashboard")
          expect(page).to have_content("Location: Morning, Espresso")
        end
      end

      context "given user's location only at a previous login > 8 hours ago" do
        it "displays only '[User]'s Dashboard'" do
          log_in_as(user_1, "Morning, Espresso")
          click_on "Sign Out"

          allow(Time).to receive(:now).and_return(Time.now + 10.hours)
          log_in_as(user_1)

          expect(page).to have_content("Megan's Dashboard")
          expect(page).to_not have_content("Location:")
        end
      end

      context "given no location at current or any previous login" do
        it "displays only '[User]'s Dashboard'" do
          log_in_as(user_1)

          expect(page).to have_content("Megan's Dashboard")
          expect(page).to_not have_content("Location:")
        end
      end

      context "given user's location at login and a previous login < 8 hours ago" do
        it "displays '[User]'s Dashboard' and 'Location:'" do
          log_in_as(user_1, "Morning, Espresso")
          click_on "Sign Out"
          log_in_as(user_1, "Evening, Coffee")
  
          expect(page).to have_content("Megan's Dashboard")
          expect(page).to have_content("Location: Evening, Coffee")
        end
      end
    end

    def log_in_as(user, location = nil)
      visit login_path
      fill_in :email, with: user.email
      fill_in :password, with: user.password
      fill_in :location, with: location if location
      click_button "Sign In"
    end

    describe "sign out button" do
      it "redirects to Welcome Page" do
        log_in_as(user_1, "Morning, Espresso")
        visit user_path(user_1)
        click_on "Sign Out"
        expect(page).to have_content("Sign In")
      end
    end

    describe "viewing party lists" do
      # test code here
    end
  end
end