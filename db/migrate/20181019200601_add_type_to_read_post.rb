class AddTypeToReadPost < ActiveRecord::Migration[5.1]
  def change
    add_column :read_posts, :entity_type, :string
    rename_column :read_posts, :micropost_id, :entity_type_id
  end
end
