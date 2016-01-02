class AddPhotoGalleryIdToNotice < ActiveRecord::Migration
  def change
    add_column :notices, :photo_gallery_id, :integer
  end
end
