class ProductItemsController < ApplicationController
  before_action :get_item, only: [:add_quantity, :reduce_quantity]

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

  def add_quantity
    @product_item.quantity += 1
    @product_item.save
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    if @product_item.quantity > 1
      @product_item.quantity -= 1
      @product_item.save
      redirect_to cart_path(@current_cart)
    elsif @product_item.quantity == 1
      destroy
    end
  end

  def delete; end

  def destroy
    item = ProductItem.find(params[:id])
    item.destroy
    redirect_to cart_path(@current_cart)
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

  def get_item
    @product_item = ProductItem.find(params[:id])
  end
end