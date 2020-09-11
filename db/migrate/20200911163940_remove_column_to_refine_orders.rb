class RemoveColumnToRefineOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :refine_orders, :state
  end
end
