class RemoveColumnFromAnswers < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :answered_id, :micropost_id
    rename_column :answers, :answering_id, :comment_id
  end
end
