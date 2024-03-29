require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
}do
  given(:user) {create(:user)}
  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    scenario 'asks a question' do

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Test text'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'Test text'
    end

    scenario 'asks a question with files' do

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Test text'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

      click_on 'Ask'

      expect(page).to have_link 'rails_helper'
      expect(page).to have_link 'spec_helper'
    end

    scenario 'asks a question with rewards' do

      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Test text'

      fill_in 'Reward name', with: 'You the best'
      attach_file 'Reward', "#{Rails.root}/spec/rails_helper.rb"

      click_on 'Ask'

      expect(page).to have_content 'Reward name'
    end

    scenario 'asks a question with errors' do

      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end
  end
  scenario 'Unauthenticated user tries asks a question' do

    visit questions_path
    expect(page).not_to have_content 'Ask question'

  end

  describe 'multisessions' do
    given(:first_user) { create(:user) }
    given(:second_user) { create(:user) }

    scenario 'ask question and second_user can see question in real time', js: true do
      Capybara.using_session('second_user') do
        sign_in(second_user)
        visit questions_path
      end

      Capybara.using_session('first_user') do
        sign_in(first_user)
        visit questions_path

        click_on 'Ask question'

        fill_in 'Title', with: 'Question with comet'
        fill_in 'Body', with: 'comet comet comet'

        click_on 'Ask'
      end

      Capybara.using_session('second_user') do
        within '.questions-list' do
          expect(page).to have_content 'comet comet comet'
        end
      end
    end
  end

end
