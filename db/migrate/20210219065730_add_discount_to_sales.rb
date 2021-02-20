class AddDiscountToSales < ActiveRecord::Migration[6.0]
  def change
    add_column :sales, :discount, :decimal, default: 0
  end
end
