# frozen_string_literal: true

class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    oauth_sign_in('github')
  end

  def vkontakte
    oauth_sign_in('Vkontakte')
  end

  private

  def oauth_sign_in(provider)
    unless request.env['omniauth.auth'].info['email']
      redirect_to new_users_oauth_email_confirmations_path
      return
    end

    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end
end
