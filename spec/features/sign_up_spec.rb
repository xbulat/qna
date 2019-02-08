require 'rails_helper'

feature 'User can sign up', %q{
  In order to aks question
  User must to sign up to service
  I'd like to be able to sign up
} do

  scenario 'User tries to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
