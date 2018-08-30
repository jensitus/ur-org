class AddGroupIdToReadPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :read_posts, :group_id, :integer
  end
end
