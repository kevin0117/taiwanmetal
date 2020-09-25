class ChageStatusTypeToRefineOrders < ActiveRecord::Migration[6.0]
  def change
    change_column :refine_orders, :status, :string, default: "pending"
  end
end