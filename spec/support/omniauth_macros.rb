# frozen_string_literal: true
module OmniauthMacros
  def mock_auth_hash(provider)
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(
      'provider' => provider.to_s,
      'uid' => '123',
      'info' => {
        'name' => 'user',
        'email' => 'user@email.com'
      }
    )
  end
end
