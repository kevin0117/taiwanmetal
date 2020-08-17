class AddTotalNetWeightToRefineOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :refine_orders, :total_net_weight, :decimal, default: 0
  end
end
