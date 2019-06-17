class AddCartPreferenceToProductItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :product_items, :cart, index: true
  end
end
