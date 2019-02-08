require 'rails_helper'

feature 'Users can destroy question', %q{
  Author is able to destroy owned question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Author tries to delete question' do
    sign_in(question.user)

    visit questions_path
    click_link('Delete', href: question_path(question))

    expect(page).to have_no_content 'MyString'
    expect(page).to have_no_content 'MyText'
  end

  scenario 'Author tries to delete not-owned question' do
    sign_in(user)
    visit questions_path

    click_link('Delete', href: question_path(question))

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

  scenario 'someone tries to delete question' do
    visit questions_path
    click_link('Delete', href: question_path(question))

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
