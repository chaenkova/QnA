class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy

  accept_nested_attributes_for :links, reject_if: :all_blank

  has_many_attached :files

  validates :title, :body, presence: true

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
