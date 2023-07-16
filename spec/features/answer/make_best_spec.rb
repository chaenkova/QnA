# frozen_string_literal: true

require 'rails_helper'

feature 'Author of question can chose best answer', %q{
  In order to show best answer a community
  As an author of the question
  I'd like to be able to mark best answer
}do
  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 2, question: question, user: user) }
  describe 'Authenticated user', js:true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can mark answer', js:true do

      within '.answers>div:first-child' do
        click_on 'Mark as best'
        expect(page).to have_content "The best"

      end
    end

    scenario 'can mark another answer' do

      within '.answers>div:last-child' do
        click_on 'Mark as best'
        expect(page.has_selector? "p.best")
      end
    end

    scenario 'best answer goes first' do
      within '.answers>div:first-child' do
        expect(page.has_selector? "p.best")
      end
    end

  end

  scenario "Unauthenticated user can't mark the best answer" , js:true do
    visit question_path(question)

    expect(page).to_not have_content 'Mark as best'
  end
  scenario "Not an author user can't mark the best answer" , js:true do
    sign_in user2
    visit question_path(question)

    expect(page).to_not have_content 'Mark as best'
  end
end