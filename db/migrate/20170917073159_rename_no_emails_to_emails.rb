class RenameNoEmailsToEmails < ActiveRecord::Migration
  def change
    rename_column :email_notifications, :no_emails, :emails
  end
end
