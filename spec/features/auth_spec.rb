require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  it "has a new user page" do
    visit new_users_url
    expect(page).to have_content('Sign Up')
  end
  user = FactoryGirl.build(:user)

  feature "signing up a user" do
    it "shows username on the homepage after signup" do
      visit new_users_url
      fill_in("Username", with: user.username)
      fill_in("Password", with: user.password)
      click_button "Sign Up"
      expect(page).to have_content(user.username)
    end
  end

  feature "logging in" do
    it "shows username on the homepage after login" do
      sign_in_as_user(user)
      expect(page).to have_content("MyString")
    end
  end

  feature "logging out" do
    it "begins with logged out state" do
      sign_in_as_user(user)
      click_button "Log Out"
      expect(page).to have_content("Sign In")
    end

    it "doesn't show username on the homepage after logout" do
      sign_in_as_user(user)
      click_button "Log Out"
      expect(page).not_to have_content("MyString")
    end
  end
end
