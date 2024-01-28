class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable,:confirmable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github vkontakte]

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :votes
  has_many :authorizations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def author?(item)
    id == item.user_id
  end

  def self.find_for_oauth(auth)
    FindForOauthService.new(auth).call
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid)
  end

  def subscribed_of?(question)
    question.subscriptions.find_by(user_id: id).present?
  end
end
