require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, user: user) }
  given(:user2) { create(:user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do

    scenario 'edits his answer', js: true do
      sign_in user
      visit question_path(question)

      click_on 'Edit'


      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_button 'Save'
      end
    end

    scenario 'edits his answer with errors', js: true do
    sign_in user
    visit question_path(question)

    click_on 'Edit'

      within '.answers' do
          fill_in 'Your answer', with: ''
          click_on 'Save'

          expect(page).to have_content answer.body
          expect(page).to_not have_button 'Save'
      end
    expect(page).to have_content "Body can't be blank"
    end

    scenario 'edit own answer whith files', js: true do
      sign_in user
      visit question_path(question)

      click_on 'Edit'

      within '.answers' do

        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

        click_on 'Save'
      end
      expect(page).to have_link 'rails_helper'
      expect(page).to have_link 'spec_helper'
    end

    scenario "tries to edit other user's answer", js: true do
      sign_in user2
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end
  end
end