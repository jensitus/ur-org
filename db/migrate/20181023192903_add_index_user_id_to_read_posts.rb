class AddIndexUserIdToReadPosts < ActiveRecord::Migration[5.1]
  def change
    add_index :read_posts, :user_id
  end
end
