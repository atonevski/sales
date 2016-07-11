class AddIndexToSalesDate < ActiveRecord::Migration
  def change
    add_index :sales, :date
  end
end
