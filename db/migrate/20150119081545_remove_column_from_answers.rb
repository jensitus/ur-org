class RemoveColumnFromAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :answered_id, :micropost_id
    rename_column :answers, :answering_id, :comment_id
  end
end
