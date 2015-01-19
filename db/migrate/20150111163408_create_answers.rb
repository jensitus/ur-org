class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :answering_id
      t.integer :answered_id

      t.timestamps
    end
  end
end
