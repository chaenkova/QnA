class DailyDigestMailer < ApplicationMailer

  def digest(user, question_list)
    @questions = question_list

    mail to: user.email
  end
end
