class AddIndexToReadPosts < ActiveRecord::Migration[5.1]
  def change
    add_index :read_posts, :read
  end
end
