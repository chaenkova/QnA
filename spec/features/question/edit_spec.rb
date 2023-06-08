require 'rails_helper'

feature 'User can edit question', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to edit the question
}do
  given(:user) {create(:user)}
  given(:question) {create(:question)}
  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path(question)
    end

    scenario 'edit own question' do
      click_on 'Edit'
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Test text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'Test text'
    end


    scenario 'edit own a question with errors' do

      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end

    scenario "tries to edit other user's question", js: true do
      sign_in user2
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
  scenario 'Unauthenticated user tries edit a question' do

    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'

  end

end
