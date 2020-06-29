class AddUserRelationToModels < ActiveRecord::Migration[6.0]
  def change
    add_reference :vendors, :user, null: false, foreign_key: true
    add_reference :customers, :user, null: false, foreign_key: true
    add_reference :price_boards, :user, null: false, foreign_key: true
    add_reference :product_lists, :user, null: false, foreign_key: true
  end
end
