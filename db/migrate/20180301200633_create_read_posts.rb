class CreateReadPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :read_posts do |t|
      t.integer :micropost_id
      t.integer :user_id
      t.boolean :read

      t.timestamps
    end
  end
end
