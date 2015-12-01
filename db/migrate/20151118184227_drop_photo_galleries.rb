class DropPhotoGalleries < ActiveRecord::Migration
  def change
    drop_table :photo_galleries do |t|
      t.string :name
      t.timestamps
    end
  end
end
