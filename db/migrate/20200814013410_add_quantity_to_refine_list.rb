class AddQuantityToRefineList < ActiveRecord::Migration[6.0]
  def change
    add_column :refine_lists, :quantity, :integer, default: 1
  end
end