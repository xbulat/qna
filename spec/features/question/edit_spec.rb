require 'rails_helper'

feature 'Users can edit questions', %q{
  Author of question is able to edit
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  describe 'Authenticated user' do
    scenario 'tries to edit question', js: true do
      sign_in(question.user)

      visit questions_path

      click_on 'Edit'

      within '.questions' do
        fill_in 'Title', with: 'MyEditedTitle'
        fill_in 'Body', with: 'MyEditedBody'
        click_on 'Edit Question'

        expect(page).to have_content 'MyEditedBody'
        expect(page).to have_content 'MyEditedTitle'
      end
    end

    scenario 'tries to edit not-owned question' do
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
