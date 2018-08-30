class AddUpdatedByToPhotoGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :photo_galleries, :last_updated_by_id, :integer
  end
end
