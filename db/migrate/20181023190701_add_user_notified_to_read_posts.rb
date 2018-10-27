class AddUserNotifiedToReadPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :read_posts, :user_notified, :boolean
  end
end
