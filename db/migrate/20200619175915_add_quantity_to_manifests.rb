class AddQuantityToManifests < ActiveRecord::Migration[6.0]
  def change
    add_column :manifests, :quantity, :integer, default: 1
  end
end
