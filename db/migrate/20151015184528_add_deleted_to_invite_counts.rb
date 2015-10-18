class AddDeletedToInviteCounts < ActiveRecord::Migration
  def change
    add_column :invite_counts, :deleted, :boolean, :default => false
  end
end
