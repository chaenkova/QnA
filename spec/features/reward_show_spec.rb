require 'rails_helper'

describe 'User can view his rewards', "
  In order to get view achieved rewards
  As an authenticated user
  I'd like to be able to view my rewards
" do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:question) { create(:question, :with_reward, user: user) }
  let(:answer) { create(:answer, user: user2, question: question) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      answer.mark_as_best
    end

    it 'views his rewards' do
      visit root_path
      click_on 'My rewards'

      expect(page).to have_content question.reward.title
    end
  end
end