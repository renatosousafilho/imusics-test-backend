class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :spotify_id
      t.string :name
      t.string :image_url
      t.string :genres

      t.timestamps
    end
  end
end
