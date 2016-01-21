class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email

      t.timestamps
    end
    add_index :invites, :email, unique: true
  end
end
