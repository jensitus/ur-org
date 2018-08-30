class AddIndexToCustomAppearance < ActiveRecord::Migration[5.2]
  def change
    add_index :custom_appearances, :user_id, unique: true
  end
end
