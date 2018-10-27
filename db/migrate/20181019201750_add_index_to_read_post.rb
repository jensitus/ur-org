class AddIndexToReadPost < ActiveRecord::Migration[5.1]
  def change
    add_index :read_posts, :entity_type
    add_index :read_posts, :entity_type_id
  end
end
