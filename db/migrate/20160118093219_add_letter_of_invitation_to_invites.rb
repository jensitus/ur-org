class AddLetterOfInvitationToInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :letter, :text
  end
end
