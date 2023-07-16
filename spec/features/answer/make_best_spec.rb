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

    scenario 'can mark another answer and he will be first' do #????
      answer_best = find('.answers>div:last-child')

      within answer_best do
        click_on 'Mark as best'
        print answer_best.value
        expect(page).to have_content "The best"
      end
      within '.answers>div:first-child' do
        expect(page).to have_content answer_best.text
      end
    end

  end

  scenario "Unauthenticated user can't mark the best answer" do
    visit question_path(question)

    expect(page).to_not have_content 'Mark as best'
  end
  scenario "Not an author user can't mark the best answer" do
    sign_in user2
    visit question_path(question)

    expect(page).to_not have_content 'Mark as best'
  end
end