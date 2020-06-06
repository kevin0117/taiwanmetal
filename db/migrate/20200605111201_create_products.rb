class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :weight
      t.decimal :cost, default: 0
      t.decimal :service_fee
      t.string :barcode
      t.boolean :on_sell, default: true
      t.string :code
      t.datetime :deleted_at
      t.references :product_list, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
