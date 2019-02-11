require 'rails_helper'

feature 'User can sign out', %q{
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }

  scenario 'Registered user tries to sign out' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit questions_path

    click_on 'Sign Out'

    expect(page).to have_content 'Signed out successfully.'

  end
end
