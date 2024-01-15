require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  given(:gist_url) {'https://gist.github.com/vkurennov/743f9367caa1039874af5a2244e1b44c'}

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'New answer', with: 'My answer'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: 'http://google.com'

    click_on 'Create'

    within '.answers' do
      expect(page).to have_link 'My gist', href: 'http://google.com'
    end
  end


  context 'User can delete link from answer' do
    let(:answer) { create(:answer, question: question, user: user) }
    let!(:link) { create(:link, linkable: answer) }

    it 'User deletes link from existing answer', js: true do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit'
      within '.answers' do
        click_on 'Remove link'
        click_on 'Save'
      end

      expect(page).not_to have_link link.name, href: link.url
    end
  end

end