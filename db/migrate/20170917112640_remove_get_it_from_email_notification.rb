class RemoveGetItFromEmailNotification < ActiveRecord::Migration
  def change
    remove_column :email_notifications, :get_it
  end
end
