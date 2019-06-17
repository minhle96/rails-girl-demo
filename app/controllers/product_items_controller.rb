class ProductItemsController < ApplicationController

  def create
    chosen_product = Product.find(params[:product_id])
    add_items_to_cart(chosen_product, params[:quantity].to_i)
    respond_to do |format|
      if @product_item.save!
        format.html { redirect_back(fallback_location: @current_cart) }
        format.js
      else
        format.html { render :new, notice: 'Error adding product to basket!' }
      end
    end
  end

  private

  def add_items_to_cart(chosen_product, quantity = 1)
    if @current_cart.product_ids.include?(chosen_product.id)
      @product_item = @current_cart.product_items.find_by(product_id: chosen_product)
      @product_item.quantity += quantity
    else
      @product_item = ProductItem.new
      @product_item.cart = @current_cart
      @product_item.product = chosen_product
      @product_item.quantity = quantity
    end
  end
end