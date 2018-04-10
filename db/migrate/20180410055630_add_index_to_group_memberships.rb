class AddIndexToGroupMemberships < ActiveRecord::Migration[5.1]
  def change
    add_index :group_memberships, [:user_id, :group_id], unique: true
  end
end
