class AddCustomAppearanceIdToBlogrolls < ActiveRecord::Migration[5.1]
  def change
    add_column :blogrolls, :custom_appearance_id, :integer
  end
end
