require 'spec_helper'
require 'rails_helper'

feature "goal comments" do
  let(:user) { FactoryGirl.build(:user) }
  let!(:goal) { FactoryGirl.create(:goal, description: "goal 1") }
  let!(:goal_comment) { FactoryGirl.create(:goal_comment) }

  scenario "has add comment button on the goal page" do
    sign_in_as_user(user)
    click_on("goal 1")
    expect(page).to have_button("Add Comment")
  end

  scenario "comment shows up after adding comment" do
    sign_in_as_user(user)
    click_on("goal 1")
    expect(page).to have_content(goal_comment.body)
  end
end

feature "user comments" do
  let(:user) { FactoryGirl.build(:user) }
  let!(:user_comment) { FactoryGirl.create(:user_comment) }

  scenario "has add comment button on the user page" do
    sign_in_as_user(user)
    visit users_url
    expect(page).to have_button("Add Comment")
  end

  scenario "comment shows up after adding comment" do
    sign_in_as_user(user)
    visit users_url
    expect(page).to have_content(user_comment.body)
  end
end
