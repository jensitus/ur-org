class CreateJoinTablePhotoGalleryUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :photo_galleries, :users do |t|
      t.index [:photo_gallery_id, :user_id]
      t.index [:user_id, :photo_gallery_id]
    end
  end
end
