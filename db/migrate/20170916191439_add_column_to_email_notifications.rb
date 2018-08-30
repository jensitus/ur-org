class AddColumnToEmailNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :email_notifications, :no_emails, :boolean
  end
end
