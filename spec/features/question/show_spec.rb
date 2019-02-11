require 'rails_helper'

feature 'Users can show questions and answers', %q{
  All users able to view questions and answers
} do

  given!(:questions) { create_list(:question, 5, :sequence) }
  given(:answer) { create(:answer, question: questions.last) }

  scenario 'Show list of questions' do
    visit questions_path

    expect(page).to have_content(/Title[1-5]+/, count: 5)
    expect(page).to have_content(/Question[1-5]+/, count: 5)
  end

  scenario 'Show question' do
    visit question_path(questions.last)

    expect(page).to have_content /Author/
    expect(page).to have_content /Title\d+/
    expect(page).to have_content /Question\d+/
  end

  scenario 'Show answer inside question page' do
    visit question_path(answer.question)

    expect(page).to have_content answer.question.title
    expect(page).to have_content answer.question.body
    expect(page).to have_content 'MyAnswerText'
  end
end
