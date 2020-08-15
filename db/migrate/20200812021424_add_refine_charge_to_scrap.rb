class AddRefineChargeToScrap < ActiveRecord::Migration[6.0]
  def change
    add_column :scraps, :refine_charge, :decimal, default: 9
  end
end
