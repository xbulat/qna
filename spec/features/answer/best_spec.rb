require 'rails_helper'

feature 'Users can choose answer as the best', %q{
  Author of question can choose the best answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:old_best_answer) { create(:answer, :best, question: question) }
  given!(:new_best_answer) { create(:answer, question: question) }

  describe 'Author of question' do
    background do
      sign_in(question.user)

      visit question_path(question)
    end

    scenario 'choose the best answer', js: true do
      click_link('Best!', href: best_answer_path(new_best_answer))

      within ".answer-id-#{new_best_answer.id}" do
        expect(page).to have_css('.trophy')
      end

      within ".answer-id-#{old_best_answer.id}" do
        expect(page).to have_css('.comment')
      end
    end

    scenario 'has only one the best answer', js: true do
      click_link('Best!', href: best_answer_path(new_best_answer))
      click_link('Best!', href: best_answer_path(old_best_answer))
      click_link('Best!', href: best_answer_path(new_best_answer))

      expect(page).to have_css('.trophy', count: 1)
    end

    scenario 'the best answer is always first', js: true do
      within all('.answers').first { expect(page).to have_content old_best_answer.body }

      within ".answer-id-#{new_best_answer.id}" do
        click_link('Best!', href: best_answer_path(new_best_answer))
      end

      within all('.answers').first { expect(page).to have_content new_best_answer.body }
    end
  end

  describe 'Not author of question' do
    scenario 'tries to choose best answer' do
      sign_in(user)

      visit question_path(question)

      expect(page).to have_no_content 'Best!'
    end
  end

  describe 'Unauthorized user' do
    scenario 'tries to choose best answer' do
      visit question_path(question)

      expect(page).to have_no_content 'Best!'
    end
  end
end
