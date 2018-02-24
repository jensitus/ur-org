class DropColumnFromCustomAppearances < ActiveRecord::Migration[5.1]
  def change
    remove_column :custom_appearances, :blogroll
  end
end
