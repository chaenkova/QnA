require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
}do
    given(:user) {User.create!(email:'user@test.tesr', password: '123123123')}

    background do visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit questions_path
  end
  scenario 'Authenticated user asks a question' do

  click_on 'Ask question'

  fill_in 'Title', with: 'Test question'
  fill_in 'Body', with: 'Test text'
  click_on 'Ask'

  save_and_open_page
  expect(page).to have_content 'Your question successfully created'
  expect(page).to have_content 'Test question'
  expect(page).to have_content 'Test text'
  end


  scenario 'Authenticated user asks a question with errors'
  scenario 'Unauthenticated user tries asks a question'

end
