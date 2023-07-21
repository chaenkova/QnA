class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  has_many_attached :files

  validates :title, :body, presence: true

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
