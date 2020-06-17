class AddReferencesToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :price_board, null: false, foreign_key: true
  end
end
