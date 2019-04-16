require 'rails_helper'

feature 'Users can edit questions', %q{
  Author of question is able to edit
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:user_link) { 'https://google.com' }

  describe 'Authenticated user' do

    before do
      sign_in(question.user)
      visit questions_path
      click_on 'Edit'
    end

    scenario 'tries to edit question', js: true do
      within '.questions' do
        fill_in 'Title', with: 'MyEditedTitle'
        fill_in 'Body', with: 'MyEditedBody'
        click_on 'Edit Question'

        expect(page).to have_content 'MyEditedBody'
        expect(page).to have_content 'MyEditedTitle'
      end
    end

    scenario 'tries to edit links of question', js: true do
      within '.questions' do
        click_on 'add link'

        fill_in 'Link name', with: 'Google'
        fill_in 'Url', with: user_link

        click_on 'Edit Question'
      end

      visit question_path(question)
      expect(page).to have_link 'Google', href: user_link
    end
  end

  describe 'Not author' do
    scenario 'tries to edit question' do
      sign_in(user)
      visit questions_path

      expect(page).to have_no_link 'Edit Question'
    end
  end

  describe 'Not authenticated user' do
    scenario 'tries to edit question' do
      visit questions_path
      expect(page).to have_no_link 'Edit Question'
    end
  end
end
