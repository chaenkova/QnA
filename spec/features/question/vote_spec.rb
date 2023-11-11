require 'rails_helper'

feature 'User can vote for question', '
  In order to rate questions
  User would like to be able to vote for question
' do
  given(:author) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user: author) }
  given!(:answer) { create(:answer, user: author, question: question) }

  describe 'Authenticated user not author' do
    background do
      sign_in(another_user)
      visit question_path(question)
    end

    scenario 'can vote+', js: true do
      within '.vote-questions' do
        expect(page).to have_selector(:link_or_button, '+')
        click_on '+'
        expect(page).to have_content '1'
      end
    end

    scenario 'can vote -', js: true do
      within '.vote-questions' do
        expect(page).to have_selector(:link_or_button, '-')
        click_on '-'
        expect(page).to have_content '-1'
      end
    end

    scenario 'can cancel vote', js: true do
      within '.vote-questions' do
        click_on '-'
        expect(page).to have_selector(:link_or_button, 'Cancel')
        click_on 'Cancel'
        expect(page).to have_content '0'
        expect(page).to have_no_selector(:link_or_button, 'Cancel')
      end
    end

    scenario 'can not cancel vote if not vote before', js: true do
      within '.vote-questions' do
        expect(page).to have_no_selector(:link_or_button, 'Cancel')
      end
    end

    scenario 'can vote after cancelling vote', js: true do
      within '.vote-questions' do
        click_on '+'
        click_on 'Cancel'
        click_on '+'
        expect(page).to have_content '1'
      end
    end

    scenario 'can not vote twice ', js: true do
      within '.vote-questions' do
        click_on '+'
        expect(page).to have_no_selector(:link_or_button, 'Rate up')
        expect(page).to have_content '1'
      end
    end

    scenario 'can see current rate', js: true do
      within '.question .vote-value' do
        expect(page).to have_content '0'
      end
    end
  end

  describe 'Authenticated user, author' do
    background do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'can not vote +', js: true do
      within '.vote-questions' do
        expect(page).to have_no_selector(:link_or_button, '+')
      end
    end

    scenario 'can not vote -', js: true do
      within '.vote-questions
' do
        expect(page).to have_no_selector(:link_or_button, '-')
      end
    end

    scenario 'can see current rating', js: true do
      within '.question .rating' do
        expect(page).to have_content '0'
      end
    end
  end

  describe 'Unauthenticated user' do
    background do
      visit question_path(question)
    end

    scenario 'can not+' do
      within '.vote-questions' do
        expect(page).to have_no_selector(:link_or_button, '+')
      end
    end

    scenario 'can not -' do
      within '.vote-questions' do
        expect(page).to have_no_selector(:link_or_button, '-')
      end
    end

    scenario 'can see current rate' do
      within '.vote-questions' do
        expect(page).to have_content '0'
      end
    end
  end
end