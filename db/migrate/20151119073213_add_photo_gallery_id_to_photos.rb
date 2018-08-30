class AddPhotoGalleryIdToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :photo_gallery_id, :integer
  end
end
