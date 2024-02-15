require 'rails_helper'

RSpec.describe SendNewAnswerService do
  let(:users) { create_list(:user, 2) }
  let(:question) { create(:question, user: users.first) }
  let(:answer) { create(:answer, question: question) }
  let(:sub_first) { create(:subscription, question: question, user: users.first) }
  let(:sub_last) { create(:subscription, question: question, user: users.last) }

  it 'send notification about new answer' do
    Subscription.find_each do |subscription|
      expect(NewAnswerMailer).to receive(:send_answer).with(subscription.user, answer).and_call_origin
    end
    subject.send_notification(answer, answer.question)
  end

  context 'unsubscribed user' do
    let(:user) { create(:user) }
    it 'does not send new answer' do
      subject.send_notification(answer, answer.question)
      expect(NewAnswerMailer).to_not receive(:send_answer).with(user, answer).and_call_original
    end
  end
end 