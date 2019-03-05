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

    scenario 'post answer with wrong form' do
      click_on 'Post Your Answer'

      expect(page).to have_content "Body can't be blank"
    end

    scenario 'post answer with attached file to question' do
      fill_in 'Body', with: 'MyAnswerText'
      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

      click_on 'Post Your Answer'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

  end

  scenario 'Unauthenticated user tries to post answer' do
    visit question_path(question)
    click_on 'Post Your Answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
