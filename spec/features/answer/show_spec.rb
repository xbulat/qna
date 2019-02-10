require 'rails_helper'

feature 'Users can show answers inside question page', %q{
  All users able to view answers'
} do

  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 5, :sequence, question: question) }

  scenario 'Show answer inside question page' do
    visit question_path(question)

    expect(page).to have_content(/MyAnswerText[1-5]+/, count: 5)
  end
end
