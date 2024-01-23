require 'rails_helper'

feature 'Guest can sign up', "
  In order to to create questions and answers
  As an unauthenticated user
  I'd like tobe able to sign up
" do
  given(:user) { create(:user) }
  background { visit new_user_registration_path }


  context 'Guest tries to sign up with valid params' do
    background do
      fill_in 'Email', with: 'newtest@test.com'
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password_confirmation
      click_on 'Sign up'
    end

    scenario 'user receives a confirmation email' do
      expect(page).to have_content 'A message with a confirmation link has been sent to your email address.'
    end

    scenario 'user can confirm email' do
      open_email(user.email.to_s)
      current_email.click_link 'Confirm my account'

      expect(page).to have_content 'Your email address has been successfully confirmed.'
    end

  end

  scenario 'Guest tries to sign up with invalid data' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: ' '
    click_on 'Sign up'

    expect(page).to have_content 'prohibited this user from being saved'
  end
end