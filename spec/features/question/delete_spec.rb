require 'rails_helper'

feature 'User can delete his question', "
  In order to delete yourself question
  As an authenticated user
  I'd lake to be able to delete my question
" do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, :with_files, user: user) }


  scenario 'Authenticated user destroys attached to question file' do

    sign_in user
    visit question_path(question)

    within '.question' do
      click_on 'Delete file'
    end
    expect(page).not_to have_content question.files.first.filename.to_s
  end

  scenario 'Author delete his question', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'

    expect(page).to_not have_content question.title
  end

  scenario "Authenticated user can't destroy other user's question", js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end

  scenario "Unauthenticated user can't destroy question", js: true do
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end
end