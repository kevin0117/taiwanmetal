class AddStateToRefineOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :refine_orders, :state, :string
  end
end
