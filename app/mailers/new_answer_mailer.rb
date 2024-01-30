class NewAnswerMailer < ApplicationMailer

  def send_answer(user, answer)
    @answer = answer
    @question = answer.question

    mail to: user.email
  end
end
