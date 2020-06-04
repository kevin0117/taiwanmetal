class CreateProductLists < ActiveRecord::Migration[6.0]
  def change
    create_table :product_lists do |t|
      t.string :name
      t.string :code
      t.text :description
      t.boolean :online, default: true

      t.timestamps
    end
  end
end
