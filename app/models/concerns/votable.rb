module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_plus(user)
    votes.create(user: user, value: 1) unless voted_before?(user)
  end

  def vote_minus(user)
    votes.create(user: user, value: -1) unless voted_before?(user)
  end

  def cancel(user)
    votes.where(user: user).destroy_all if voted_before?(user)
  end

  def voted_before?(user)
    votes.where(user: user).any?
  end

  def rating
    votes.sum(:value)
  end
end