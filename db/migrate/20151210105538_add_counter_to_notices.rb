class AddCounterToNotices < ActiveRecord::Migration
  def change
    add_column :notices, :count, :integer, default: 0
  end
end
