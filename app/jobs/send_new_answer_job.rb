class SendNewAnswerJob < ApplicationJob
  queue_as :default

  def perform(answer, question)
    SendNewAnswerService.new.send_notification(answer, question)
  end
end