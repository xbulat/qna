require 'rails_helper'

feature 'Users can destroy answer', %q{
  As an authenticated user
  Author is able to destroy owned answer
  User isn't able to destroy not owned answer
} do

  given(:user) { create(:user) }
  given!(:answer) { create(:answer, :with_question) }

  scenario 'author tries to delete answer' do
    sign_in(answer.user)

    visit question_path(answer.question)
    click_link('Delete', href: answer_path(answer))

    expect(page).to have_no_content 'MyAnswerText'
    expect(page).to have_content 'Your answer successfully deleted.'
  end

  scenario 'author tries to delete not owned answer' do
    sign_in(user)

    visit question_path(answer.question)
    expect(page).to have_no_content 'Delete'
  end
end
