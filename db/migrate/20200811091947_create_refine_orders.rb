class CreateRefineOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :refine_orders do |t|
      t.date :request_date
      t.integer :status
      t.decimal :refine_fee
      t.decimal :result_weight
      t.decimal :result_purity
      t.string :slug
      t.text :note
      t.string :recipient
      t.references :scrap, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
