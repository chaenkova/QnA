require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:link) { create(:link, linkable: question) }
  given(:gist_url) { 'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c' }

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).not_to have_link 'My gist', href: gist_url
  end

  describe  'User can delete link from question' do

    scenario 'User deletes link from existing question', js: true do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit'
      click_on 'Remove link'
      click_on 'Save'

      expect(page).not_to have_link link.name, href: link.url
    end
  end


end