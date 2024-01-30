# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
    can :rewards,  User
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :me, User, user_id: user.id
    can :create, [Question, Answer, Comment, Subscription]
    can :update, [Question, Answer], { user_id: user.id }
    can :destroy, [Question, Answer, Subscription], { user_id: user.id }
    can :delete_file, [Question, Answer], { user_id: user.id }
    can :mark_as_best, [Answer]
    can :vote_plus, [Question, Answer, Comment]
    can :vote_minus, [Question, Answer, Comment]
    can :cancel, [Question, Answer, Comment]

  end
end
