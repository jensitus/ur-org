class AddUpdatedByToPhotoGalleries < ActiveRecord::Migration
  def change
    add_column :photo_galleries, :last_updated_by_id, :integer
  end
end
