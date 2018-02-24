class CreateCustomAppearances < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_appearances do |t|
      t.string :navbar
      t.string :blogroll

      t.timestamps
    end
  end
end
