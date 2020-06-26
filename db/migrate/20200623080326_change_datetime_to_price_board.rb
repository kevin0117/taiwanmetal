class ChangeDatetimeToPriceBoard < ActiveRecord::Migration[6.0]
  def change
    change_column :price_boards, :price_date, :date
  end
end
