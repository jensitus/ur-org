class AddPhotoGalleryIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :photo_gallery_id, :integer
  end
end
