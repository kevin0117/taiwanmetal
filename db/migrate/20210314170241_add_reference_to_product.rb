class AddReferenceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :purchase_order, null: true, foreign_key: true
  end
end