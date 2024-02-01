class PurchaseItemsController < ApplicationController
  def create
    @purchase = current_user.current_purchase
    product = Product.find(params[:purchase_item][:product_id].to_i)
    @purchase_item = @purchase.add_product(product, params[:purchase_item][:quantity].to_i)

    if @purchase_item.save
      @purchase.update!(total_price: @purchase.total_price + (product.price * params[:purchase_item][:quantity].to_i))
      redirect_to products_path, notice: 'Product added to current purchase.'
    else
      render :new
    end
  end
end
