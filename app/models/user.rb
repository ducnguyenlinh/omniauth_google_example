class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i(google_oauth2)

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(
          email:      auth.info.email,
          provider:   auth.provider,
          uid:        auth.uid,
          token:      auth.credentials.token,
          expires_at: auth.credentials.expires_at,
          password:   Devise.friendly_token[0, 20]
      )
    end

    user
  end
end
