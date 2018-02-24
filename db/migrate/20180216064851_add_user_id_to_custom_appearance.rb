class AddUserIdToCustomAppearance < ActiveRecord::Migration[5.1]
  def change
    add_column :custom_appearances, :user_id, :integer
  end
end
