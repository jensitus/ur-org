class DropColumnFromCustomAppearances < ActiveRecord::Migration[5.2]
  def change
    remove_column :custom_appearances, :blogroll
  end
end
