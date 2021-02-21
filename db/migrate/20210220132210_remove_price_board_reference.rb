class RemovePriceBoardReference < ActiveRecord::Migration[6.0]
  def change
    change_table :products do |t|
      t.remove_references :price_board
    end
  end
end