class Reward < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  has_one_attached :image

  validates :title, presence: true

  validate :check_image_presence

  def check_image_presence
    errors.add(:image) unless image.attached?
  end
end