class RenameNoEmailsToEmails < ActiveRecord::Migration[5.2]
  def change
    rename_column :email_notifications, :no_emails, :emails
  end
end
