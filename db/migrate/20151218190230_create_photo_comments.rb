class CreatePhotoComments < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_comments do |t|
      t.integer :photo_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
