class Cart < ApplicationRecord
  has_many :product_items, dependent: :destroy

  def product_ids
    self.product_items.map(&:product_id)
  end

  def total_quantity
    self.product_items.sum(&:quantity)
  end

  def total
    sum = 0
    product_items.each do |product_item|
      sum += product_item.total_price
    end
    sum
  end
end
