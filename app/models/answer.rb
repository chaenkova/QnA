class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  has_many_attached :files
  def mark
    best = question.answers.where(best: true)
    unless best.first == self
      best.update(best: false)
      self.update(best: true)
    end
  end

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
