class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  def mark
    best = question.answers.where(best: true)
    unless best.first == self
      best.update(best: false)
      self.update(best: true)
    end
  end
end
