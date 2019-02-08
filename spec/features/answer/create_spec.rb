require 'rails_helper'

feature 'User can create answer', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to give answer
} do

  given(:user) {create(:user)}
  given(:question) {create(:question)}

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'post answer to question' do
      fill_in 'Body', with: 'MyAnswerText'
      click_on 'Post Your Answer'

      expect(page).to have_content 'Your answer successfully created.'
      expect(page).to have_content 'MyAnswerText'
    end

    scenario 'post answer with errors' do
      click_on 'Post Your Answer'

      expect(page).to have_content "Add Answer"
    end
  end

  scenario 'Unauthenticated user tries to post answer' do
    visit question_path(question)
    click_on 'Post Your Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
