class CreateScraps < ActiveRecord::Migration[6.0]
  def change
    create_table :scraps do |t|
      t.datetime :collected_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :title
      t.decimal :gross_weight
      t.decimal :wastage_rate, default: 0.95
      t.decimal :net_weight
      t.decimal :gold_buying
      t.decimal :total_price
      t.boolean :in_stock, default: true
      t.string :code
      t.datetime :deleted_at
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
