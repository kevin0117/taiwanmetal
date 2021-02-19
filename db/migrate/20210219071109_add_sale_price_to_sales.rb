class AddSalePriceToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :sale_price, :decimal, default: 0
  end
end
