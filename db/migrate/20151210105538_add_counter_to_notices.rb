class AddCounterToNotices < ActiveRecord::Migration[5.2]
  def change
    add_column :notices, :count, :integer, default: 0
  end
end
