require 'rails_helper'

feature 'Users can destroy question', %q{
  Author is able to destroy owned question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, :with_file) }

  describe 'Authenticated user' do
    scenario 'tries to delete question' do
      sign_in(question.user)

      visit questions_path
      click_link('Delete', href: question_path(question))

      expect(page).to have_content 'Your question has been deleted.'
      expect(page).to have_no_content 'MyString'
      expect(page).to have_no_content 'MyText'
    end

    scenario 'tries to delete attached file' do
      sign_in(question.user)

      visit question_path(question)
      click_link('Purge', href: attachment_path(question.files.first.id))

      expect(page).to have_no_link 'Purge'
    end

    scenario 'tries to delete not-owned question' do
      sign_in(user)
      visit questions_path

      expect(page).to have_no_link 'Delete'
    end

    scenario 'tries to delete not-owned files' do
      sign_in(user)
      visit question_path(question)

      expect(page).to have_no_link 'Purge'
    end
  end

  describe 'Not authenticated user' do
    before { visit questions_path }

    scenario 'tries to delete question' do
      expect(page).to have_no_link 'Delete'
    end

    scenario 'tries to delete question' do
      expect(page).to have_no_link 'Purge'
    end
  end
end
