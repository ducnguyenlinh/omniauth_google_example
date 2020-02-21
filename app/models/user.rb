class User < ApplicationRecord
  devise :trackable, :omniauthable, omniauth_providers: %i(google_oauth2)

  def self.from_omniauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.info.uid)

    unless user
      user = User.create(
          provider:       auth.provider,
          uid:            auth.uid,
          token:          auth.credentials.token,
          refresh_token:  auth.credentials.refresh_token,
          expires_at:     auth.credentials.expires_at
      )
    end

    user
  end
end
