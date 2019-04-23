require 'rails_helper'

feature 'User can vote for a answer', %q{
  In order to show that answer is good
  As an authenticated user
  I'd like to be able to set 'like' for answer.
} do

  given(:user) { create(:user) }
  given(:author) { create(:user) }
  given!(:answer) { create(:answer, :with_question, user: author) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(answer.question)
    end

    scenario 'is able to like the answer' do
      click_link('0', href: like_answer_path(answer))

      within ".votes-answer-id-#{answer.id}" do
        expect(page).to have_content 'Score: 1'
      end
    end


    scenario 'is able to dislike the answer' do
      click_link('0', href: dislike_answer_path(answer))

      within ".votes-answer-id-#{answer.id}" do
        expect(page).to have_content 'Score: -1'
      end
    end

    scenario 'can not votes again' do
      click_link(href: dislike_answer_path(answer))

      within ".votes-links.answer-id-#{answer.id}" do
        expect(page).to_not have_link(href: like_answer_path(answer))
        expect(page).to_not have_link(href: dislike_answer_path(answer))
      end
    end

    scenario 'is able to revoke his vote' do
      click_link(href: dislike_answer_path(answer))
      click_link(href: revoke_answer_path(answer))

      within ".votes-links.answer-id-#{answer.id}" do
        expect(page).to have_link(href: like_answer_path(answer))
        expect(page).to have_link(href: dislike_answer_path(answer))
      end
    end
  end

  describe 'Author of answer', js: true do
    background do
      sign_in(author)

      visit question_path(answer.question)
    end

    scenario 'is not able to vote' do
      within ".answer-id-#{answer.id}" do
        expect(page).to_not have_link '0', href: like_answer_path(answer)
        expect(page).to_not have_link '0', href: dislike_answer_path(answer)
      end
    end
  end
end
