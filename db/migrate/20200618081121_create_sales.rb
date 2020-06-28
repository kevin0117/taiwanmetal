class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.datetime :sale_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.decimal :gold_selling
      t.decimal :gold_buying
      t.decimal :exchange_weight
      t.decimal :wastage_rate, default: 0.95
      t.decimal :net_weight
      t.integer :payment_method, default: 0
      t.decimal :service_fee
      t.decimal :weight
      t.decimal :total_price
      t.references :product, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
