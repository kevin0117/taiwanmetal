class CreateRefineLists < ActiveRecord::Migration[6.0]
  def change
    create_table :refine_lists do |t|
      t.references :scrap, null: false, foreign_key: true
      t.references :refine_order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
