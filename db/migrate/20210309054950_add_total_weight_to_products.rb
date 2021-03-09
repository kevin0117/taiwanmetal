class AddTotalWeightToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :total_weight, :decimal, default: 0
    add_column :products, :total_service_fee, :integer, default: 0
  end
end
