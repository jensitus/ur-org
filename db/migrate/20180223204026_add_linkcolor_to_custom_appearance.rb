class AddLinkcolorToCustomAppearance < ActiveRecord::Migration[5.2]
  def change
    add_column :custom_appearances, :linkcolor, :text
  end
end
