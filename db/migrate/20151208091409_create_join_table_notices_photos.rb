class CreateJoinTableNoticesPhotos < ActiveRecord::Migration[5.2]
  def change
    create_join_table :notices, :photos do |t|
      t.index [:notice_id, :photo_id]
      t.index [:photo_id, :notice_id]
    end
  end
end
