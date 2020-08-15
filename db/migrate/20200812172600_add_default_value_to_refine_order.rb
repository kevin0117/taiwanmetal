class AddDefaultValueToRefineOrder < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:refine_orders, :status, 0)
  end
end
