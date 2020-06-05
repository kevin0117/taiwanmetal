class AddIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :deleted_at
    add_index :products, :code, unique: true
  end
end
