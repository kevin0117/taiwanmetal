class CreateManifests < ActiveRecord::Migration[6.0]
  def change
    create_table :manifests do |t|
      t.references :product, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true

      t.timestamps
    end
  end
end
