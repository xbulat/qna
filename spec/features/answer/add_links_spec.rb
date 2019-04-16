require 'rails_helper'

feature 'User can add links to answer', %q{
 In order to provide additional info to my answer
 As an answer's author
 I'd like to be able to add links
} do

 given!(:question) { create(:question) }
 given(:user) { create(:user) }

 given(:gist_url) { 'https://gist.github.com/xbulat/83ce41c77955f86eeee9c475783388da' }
 given(:user_url) { 'https://google.com' }

 background do
   sign_in(question.user)
   visit question_path(question)

   within '.new-answer' do
     fill_in 'Body', with: 'My Answer'
   end
 end

 scenario 'User adds gist link when asks answer' do
   fill_in 'Link name', with: 'My gist'
   fill_in 'Url', with: gist_url

   click_on 'Post Your Answer'

   expect(page).to have_link 'Test1', href: 'https://gist.githubusercontent.com/xbulat/83ce41c77955f86eeee9c475783388da/raw/e5e8197e6ca422181e7fb42c65ad02d5337c653c/Test1'
 end

 scenario 'User adds user link when asks answer' do
   fill_in 'Link name', with: 'Google'
   fill_in 'Url', with: user_url

   click_on 'Post Your Answer'

   expect(page).to have_link 'Google', href: user_url
 end
end
