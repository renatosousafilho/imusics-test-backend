class SyncFollowingArtistsJob < ActiveJob::Base
  def perform(user)
    artists = user.following_artists
    artists.each do |a|
      artist = Artist.find_or_create_by(spotify_id: a.id, name: a.name)
      if artist.image_url.nil?
        image = a.images.detect { |i| i['width'] == 640 }
        image ||= a.images.last
        artist.image_url = image['url']
      end
      artist.genres = a.genres.join(",") if artist.genres.nil?
      artist.save
      ArtistFollowing.find_or_create_by(user: user, artist: artist)
    end
  end
end
