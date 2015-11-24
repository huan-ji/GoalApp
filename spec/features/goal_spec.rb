require 'spec_helper'
require 'rails_helper'

feature "crud goals" do
  it "has an index page with create goals" do
    visit goals_url
    expect(page).to have_button("New Goal")
  end

  user = FactoryGirl.build(:user)

  it "creates a goal" do
    sign_in_as_user(user)
    create_goal("This is a public goal")
    expect(page).to have_content("This is a public goal")
  end

  it "validates description when creating" do
    sign_in_as_user(user)
    click_button "New Goal"
    click_button "Add Goal"
    expect(page).to have_content("Description can't be blank")
  end

  scenario "edits a goal" do
    sign_in_as_user(user)
    create_goal("This is a public goal")
    click_button "Edit Goal"
    fill_in("Description", with: "This is a public goal edited")
    click_button "Update Goal"
    expect(page).to have_content("This is a public goal edited")
  end

  scenario "deletes a goal" do
    sign_in_as_user(user)
    create_goal("This is a public goal")
    delete_goal
    expect(page).not_to have_content("This is a public goal")
  end

  scenario "button to go to index" do
    sign_in_as_user(user)
    create_goal("This is a public goal")
    click_link("Goals")
    expect(page).to have_button("New Goal")
  end
end

feature "test for public/private goals" do
  let(:user) { FactoryGirl.build(:user) }
  let(:user2) { FactoryGirl.build(:john) }

  scenario "show public goals" do
    sign_in_as_user(user)
    create_goal("This is a public goal")
    click_button "Log Out"
    sign_in_as_user(user2)
    expect(page).to have_content("This is a public goal")
  end

  scenario "do not show private goals unless owned" do
    create_private_goal(user)
    click_link "Goals"
    expect(page).to have_content("This is a private goal")
    click_button "Log Out"
    sign_in_as_user(user2)
    expect(page).not_to have_content("This is a private goal")
  end
end

feature "complete/incomplete goals" do

  let(:user) { FactoryGirl.build(:user) }
  let!(:goal) { FactoryGirl.create(:goal, description: "goal 1") }

  scenario "Show page has completed button when goal is incomplete" do
    sign_in_as_user(user)
    click_on("goal 1")
    expect(page).to have_button("Completed")
  end

  scenario "Clicking completed button on show page completes goal" do
    sign_in_as_user(user)
    click_on("goal 1")
    click_on("Completed")
    expect(page).not_to have_button("Completed")
  end

end
