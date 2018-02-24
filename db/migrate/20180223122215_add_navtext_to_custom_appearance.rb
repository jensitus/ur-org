class AddNavtextToCustomAppearance < ActiveRecord::Migration[5.1]
  def change
    add_column :custom_appearances, :navtext, :text
  end
end
