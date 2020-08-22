class AddCloserToCommodity < ActiveRecord::Migration[6.0]
  def change
    add_column :commodities, :closer_id, :integer
  end
end
