class AddLetterOfInvitationToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :letter, :text
  end
end
