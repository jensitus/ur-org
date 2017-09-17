class AddColumnToEmailNotifications < ActiveRecord::Migration
  def change
    add_column :email_notifications, :no_emails, :boolean
  end
end
