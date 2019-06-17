class Cart < ApplicationRecord
  has_many :product_items

  def product_ids
    self.product_items.map(&:product_id)
  end

  def total_quantity
    self.product_items.sum(&:quantity)
  end
end
