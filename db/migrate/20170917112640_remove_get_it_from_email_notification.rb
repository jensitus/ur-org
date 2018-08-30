class RemoveGetItFromEmailNotification < ActiveRecord::Migration[5.2]
  def change
    remove_column :email_notifications, :get_it
  end
end
