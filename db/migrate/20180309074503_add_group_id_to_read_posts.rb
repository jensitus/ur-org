class AddGroupIdToReadPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :read_posts, :group_id, :integer
  end
end
