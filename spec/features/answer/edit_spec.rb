require 'rails_helper'

feature 'Users can edit answers', %q{
  Author of answer is able to edit
} do

  given(:user) { create(:user) }
  given!(:answer) { create(:answer, :with_question) }

  describe 'Authenticated user' do
    background do
      sign_in(answer.user)

      visit question_path(answer.question)
    end

    scenario 'tries to edit answer', js: true do
      click_on 'Edit'

      within '.answers' do
        fill_in 'Body', with: 'MyEditedBody'
        click_on 'Edit Answer'

        expect(page).to have_no_content 'MyEditedBody'
      end
    end

    scenario 'tries to edit not-owned question' do
      expect(page).to have_no_content 'Edit Answer'
    end
  end

  describe 'Not authenticated user' do
    scenario 'tries to edit answer' do
      visit question_path(answer.question)
      expect(page).to have_no_content 'Edit Answer'
    end
  end
end
