require 'rails_helper'

feature 'User can add links to question', %q{
 In order to provide additional info to my question
 As an question's author
 I'd like to be able to add links
} do

 given(:user) { create(:user) }
 given(:gist_url) { 'https://gist.github.com/xbulat/83ce41c77955f86eeee9c475783388da' }
 given(:user_url) { 'https://google.com' }

 background do
   sign_in(user)
   visit new_question_path

   fill_in 'question_title', with: 'MyTitle'
   fill_in 'question_body', with: 'MyBody'
 end

 scenario 'User adds gist link when asks question' do
   fill_in 'Link name', with: 'My gist'
   fill_in 'Url', with: gist_url

   click_on 'Ask'

   expect(page).to have_link 'Test1', href: 'https://gist.githubusercontent.com/xbulat/83ce41c77955f86eeee9c475783388da/raw/e5e8197e6ca422181e7fb42c65ad02d5337c653c/Test1'
 end

 scenario 'User adds user link when asks question' do
   fill_in 'Link name', with: 'Google'
   fill_in 'Url', with: user_url

   click_on 'Ask'

   expect(page).to have_link 'Google', href: user_url
 end
end
