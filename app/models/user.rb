class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :omniauthable

  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
  foreign_key: :resource_owner_id,
  dependent: :delete_all # or :destroy if you need callbacks

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
  foreign_key: :resource_owner_id,
  dependent: :delete_all # or :destroy if you need callbacks


  def self.from_omniauth(auth)
    expires_at = auth.credentials.expires_at.present? ? Time.at(auth.credentials.expires_at) : nil

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.spotify_expires_at = expires_at
      user.spotify_access_token = auth.credentials.token
      user.spotify_refresh_token = auth.credentials.refresh_token
      user.spotify_access_token_secret = auth.credentials.secret
    end
  end

end
