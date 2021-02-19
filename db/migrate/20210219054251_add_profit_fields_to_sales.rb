class AddProfitFieldsToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :service_profit, :decimal, default: 0
    add_column :sales, :weight_profit, :decimal, default: 0
  end
end