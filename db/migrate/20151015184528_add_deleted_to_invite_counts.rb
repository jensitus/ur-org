class AddDeletedToInviteCounts < ActiveRecord::Migration[5.2]
  def change
    add_column :invite_counts, :deleted, :boolean, :default => false
  end
end
