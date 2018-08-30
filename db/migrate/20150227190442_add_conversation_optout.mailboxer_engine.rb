# This migration comes from mailboxer_engine (originally 20131206080416)
class AddConversationOptout < ActiveRecord::Migration[5.2]
  def self.up
    create_table :mailboxer_conversation_opt_outs do |t|
      t.references :unsubscriber, :polymorphic => true, index: { name: 'conversation_unsubscr_index' }
      t.references :conversation
    end
    add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", :name => "mb_opt_outs_on_conversations_id", :column => "conversation_id"
  end

  def self.down
    remove_foreign_key "mailboxer_conversation_opt_outs", :name => "mb_opt_outs_on_conversations_id"
    drop_table :mailboxer_conversation_opt_outs
  end
end
