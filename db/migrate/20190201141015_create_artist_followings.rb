class CreateArtistFollowings < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_followings do |t|
      t.references :user, foreign_key: true
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
