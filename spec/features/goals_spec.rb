require 'rails_helper'

feature "create new goal page" do
  scenario "can't access unless logged in" do
    visit new_goal_url
    expect(page).not_to have_content "New Goal"
  end

  feature "when logged in" do
    before(:each) do
      FactoryGirl.create(:user, username: 'person', password: '123456')
      visit new_session_url
      fill_in 'username', with: 'person'
      fill_in 'password', with: '123456'
      click_on 'Sign In'
      visit new_goal_url
    end

    scenario "can access if logged in" do
      expect(page).to have_content "New Goal"
    end

    scenario "can create a new goal" do
      fill_in 'description', with: Faker::Hipster.sentence
      click_on 'Set Goal'

      expect(current_path).to eq( goal_path(Goal.last) )
    end

    scenario "can't create a goal without a description" do
      click_on 'Set Goal'

      expect(current_path).to eq( new_goal_path )
    end

    scenario "can't edit goals that don't belong to current user" do
      user2 = FactoryGirl.create(:user, username: 'cindy')
      goal = FactoryGirl.create(:goal, user_id: user2.id)

      visit edit_goal_url(goal)
      expect(current_path).not_to eq(edit_goal_path(goal))
    end

    scenario "can edit goals that belong to current user" do
      user = User.find_by_username('person')
      goal = FactoryGirl.create(:goal, user_id: user.id)

      visit edit_goal_url(goal)
      expect(current_path).to eq(edit_goal_path(goal))
    end

    scenario "can't destroy goals that don't belong to current user" do
      user2 = FactoryGirl.create(:user, username: 'cindy')
      goal = FactoryGirl.create(:goal, user_id: user2.id)

      visit goal_url(goal)
      expect(page).not_to have_content("Delete Goal")
    end

    scenario "can destroy goals that belong to current user" do
      user = User.find_by_username('person')
      goal = FactoryGirl.create(:goal, user_id: user.id)

      visit goal_url(goal)
      click_on "Delete Goal"
      expect(page).to have_content("Goal was deleted")
    end

    scenario "cannot view other users' private goals" do
      user2 = FactoryGirl.create(:user, username: 'cindy')
      goal = FactoryGirl.create(:goal, user_id: user2.id, publicly_viewable: false)

      visit goal_url(goal)
      expect(current_path).not_to eq(goal_path(goal))
    end
  end
end
