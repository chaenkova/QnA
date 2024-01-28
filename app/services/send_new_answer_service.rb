# frozen_string_literal: true
class SendNewAnswerService
  def send_notification(answer, question)
    question.subscriptions.find_each(batch_size:500) do |subs|
      NewAnswerMailer.send_answer(subs.user, answer).deliver_later
    end
  end
end
