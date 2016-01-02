class CreatePhotoGalleries < ActiveRecord::Migration
  def change
    create_table :photo_galleries do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
