class CreateEmailNotifications < ActiveRecord::Migration
  def change
    create_table :email_notifications do |t|
      t.integer :user_id
      t.integer :micropost_id
      t.boolean :get_it
    end
  end
end
