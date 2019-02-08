require 'rails_helper'

feature 'Users can show questions and answers', %q{
  All users able to view questions and answers
} do

  given!(:answer) { create(:answer, :with_question) }

  scenario 'Show list of questions' do
    visit questions_path

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

  scenario 'Show question' do
    visit question_path(answer.question)

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

  scenario 'Show answer inside question page' do
    visit question_path(answer.question)

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
    expect(page).to have_content 'MyAnswerText'
  end
end
