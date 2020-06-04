class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.text :description
      t.boolean :online, default: true

      t.timestamps
    end
  end
end
