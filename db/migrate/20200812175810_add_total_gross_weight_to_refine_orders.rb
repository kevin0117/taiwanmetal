class AddTotalGrossWeightToRefineOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :refine_orders, :total_gross_weight, :decimal, default: 0
  end
end
