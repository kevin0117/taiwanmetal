class AddDefaultValueToSales < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:sales, :net_weight, 0)
  end
end
