class CreateCommodities < ActiveRecord::Migration[6.0]
  def change
    create_table :commodities do |t|
      t.decimal :weight
      t.decimal :unit_price
      t.decimal :total_price
      t.string :status
      t.integer :action
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
