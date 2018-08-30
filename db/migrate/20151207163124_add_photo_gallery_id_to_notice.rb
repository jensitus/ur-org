class AddPhotoGalleryIdToNotice < ActiveRecord::Migration[5.2]
  def change
    add_column :notices, :photo_gallery_id, :integer
  end
end
