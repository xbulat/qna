require 'rails_helper'

feature 'Users can edit answers', %q{
  Author of answer is able to edit
} do

  given(:user) { create(:user) }
  given!(:answer) { create(:answer, :with_question) }
  given(:user_link) { 'https://google.com' }

  describe 'Authenticated user' do
    background do
      sign_in(answer.user)

      visit question_path(answer.question)
      click_on 'Edit'
    end

    scenario 'tries to edit answer', js: true do
      within '.answers' do
        fill_in 'Body', with: 'MyEditedBody'
        click_on 'Edit Answer'

        expect(page).to have_content 'MyEditedBody'
      end
    end

    scenario 'tries to edit links', js: true do
      within '.answers' do
        click_on 'add link'

        fill_in 'Link name', with: 'Google'
        fill_in 'Url', with: user_link

        click_on 'Edit Answer'

        expect(page).to have_link 'Google', href: user_link
      end
    end
  end

  describe 'Not author' do
    scenario 'tries to edit answer' do
      expect(page).to have_no_link 'Edit Answer'
    end
  end

  describe 'Not authenticated user' do
    scenario 'tries to edit answer' do
      visit question_path(answer.question)
      expect(page).to have_no_link 'Edit Answer'
    end
  end
end
