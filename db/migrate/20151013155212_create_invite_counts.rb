class CreateInviteCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_counts do |t|
      t.integer :invite_id
      t.integer :user_id

      t.timestamps
    end
  end
end
