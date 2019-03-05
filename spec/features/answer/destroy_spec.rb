require 'rails_helper'

feature 'Users can destroy answer', %q{
  As an authenticated user
  Author is able to destroy owned answer
  User isn't able to destroy not owned answer
} do

  given(:user) { create(:user) }
  given!(:answer) { create(:answer, :with_question, :with_file) }

  describe 'Authenticated user' do
    scenario 'author tries to delete answer' do
      sign_in(answer.user)
      visit question_path(answer.question)


      click_link('Delete', href: answer_path(answer))

      expect(page).to have_no_content 'MyAnswerText'
      expect(page).to have_content 'Your answer successfully deleted.'
    end

    scenario 'author tries to delete attached file' do
      sign_in(answer.user)
      visit question_path(answer.question)

      click_link('Purge', href: attachment_path(answer.files.first.id))

      expect(page).to have_no_link 'Purge'
    end

    scenario 'author tries to delete not owned answer' do
      sign_in(user)

      visit question_path(answer.question)

      expect(page).to have_no_link 'Delete'
    end

    scenario 'author tries to delete not owned files' do
      sign_in(user)

      visit question_path(answer.question)

      expect(page).to have_no_link 'Purge'
    end
  end

  describe 'Not authenticated user' do
    before { visit question_path(answer.question) }

    scenario 'tries to delete answer' do
      expect(page).to have_no_link 'Delete'
    end

    scenario 'tries to delete attached file' do
      expect(page).to have_no_link 'Purge'
    end
  end
end
