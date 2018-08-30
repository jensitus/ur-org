class AddGroupIdToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :group_id, :integer
  end
end
