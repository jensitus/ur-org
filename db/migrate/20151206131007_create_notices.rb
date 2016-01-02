class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.text :description
      t.integer :user_id
      t.string :picture

      t.timestamps
    end
  end
end
