require 'rails_helper'

feature 'User can delete his answer', "
  In order to delete yourself answer
  As an authenticated user
  I'd like to be able to delete my answer" do

  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let!(:answer) { create(:answer, :with_files, question: question, user: user) }

  scenario 'Authenticated user destroys attached to answer file' do

    sign_in(user)
    visit question_path question

    click_on 'Delete file'
    expect(page).not_to have_content answer.files.first.filename.to_s
  end

  scenario 'Authenticated user destroys own answer', js: true do
    sign_in(answer.user)
    visit question_path answer.question
    click_on 'Delete'

    expect(page).to_not have_content answer.body
  end

  scenario "Authenticated user can't destroy other user's answer" do
    sign_in(user)
    visit question_path answer.question

    expect(page).to_not have_link 'Delete answer'
  end

  scenario "Unauthenticated user destroys other user's answer" do
    visit question_path answer.question

    expect(page).to_not have_link 'Delete answer'
  end
end