class AddPrivateToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :private, :boolean
  end
end
