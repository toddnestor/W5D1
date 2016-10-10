require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New user"
  end

  feature "signing up a user" do

    before(:each) do
      visit new_user_url
      fill_in 'username', with: 'testing_username'
      fill_in 'password', with: 'biscuits'
      click_on 'Create User'
    end

    scenario "redirects to user show page" do
      expect(current_path).to eq(user_path(User.last))
    end

    scenario "shows username on the homepage after signup" do
      expect(page).to have_content('testing_username')
    end

  end

end

feature "logging in" do
  before(:each) do
    FactoryGirl.create(:user, username: 'person', password: '123456')
  end

  feature 'with valid credentials' do
    scenario "shows username on the homepage after login" do
      visit new_session_url
      fill_in 'username', with: 'person'
      fill_in 'password', with: '123456'
      click_on 'Sign In'

      expect(page).to have_content('person')
    end
  end

  feature 'with invalid credentials' do

    scenario "stays on the new session page" do
      visit new_session_url
      fill_in 'username', with: 'person'
      fill_in 'password', with: '123457'
      click_on 'Sign In'
      expect(current_path).to eq(new_session_path)
    end
  end
end

feature "logging out" do
  before(:each) do
    FactoryGirl.create(:user, username: 'person', password: '123456')
    visit new_session_url
    fill_in 'username', with: 'person'
    fill_in 'password', with: '123456'
    click_on 'Sign In'
  end

  scenario "doesn't show username on the homepage after logout" do
    click_on 'Log out'
    expect(page).not_to have_content("Logged in as")
  end
end
