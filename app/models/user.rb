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

  has_many :artist_followings
  has_many :artists, through: :artist_followings


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

  # TODO: instanciar cliente do spotify através dos dados salvos no banco.
  def spotify_client
    credentials = {"token" => self.spotify_access_token, "refresh_token"=> self.spotify_refresh_token, "expires_at"=> self.spotify_expires_at.to_i, "expires"=> true }
    options = { "credentials" => credentials }
    @client ||= RSpotify::User.new(options)
    @client
  end

  def fetch_following_artists(after=nil)
    params = {type: 'artist', limit: 50}
    params[:after] = after if after.present?
    spotify_client.following(params)
  end

  def following_artists
    artists = []
    while true do
      from = (artists.empty?) ? nil : artists.last.id
      hits = self.fetch_following_artists(from)
      break if hits.size == 0
      artists += hits
    end

    artists.sort_by { |u| u.name }
  end
end
