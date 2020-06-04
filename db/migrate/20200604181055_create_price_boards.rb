class CreatePriceBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :price_boards do |t|
      t.datetime :price_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.decimal :gold_selling
      t.decimal :gold_buying
      t.decimal :platinum_selling
      t.decimal :platinum_buying
      t.decimal :wholesale_gold_selling
      t.decimal :wholesale_gold_buying
      t.decimal :wholesale_platinum_selling
      t.decimal :wholesale_platinum_buying
      t.text :description
      t.boolean :online

      t.timestamps
    end
  end
end
