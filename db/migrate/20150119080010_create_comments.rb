class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, index: true

      t.timestamps null: false
    end
    add_index :comments, [:user_id, :created_at]
  end
end
