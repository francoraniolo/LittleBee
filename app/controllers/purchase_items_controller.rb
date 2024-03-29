class PurchaseItemsController < ApplicationController
  def create
    @purchase = current_user.current_purchase
    product = Product.find(params[:purchase_item][:product_id].to_i)
    @purchase_item = @purchase.add_product(product, params[:purchase_item][:quantity].to_i)

    if @purchase_item.save
      @purchase.update!(total_price: @purchase.total_price + (product.price * params[:purchase_item][:quantity].to_i))

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("product_#{product.id}", partial: 'products/product', locals: { product: product }),
            turbo_stream.update("total_price", partial: 'layouts/total_price', locals: { purchase: @purchase })
          ]
        end
        format.html { redirect_to products_path, notice: 'Product added to current purchase.' }
      end
    else
      render :new
    end
  end

  def destroy
    @purchase = current_user.current_purchase
    @purchase_item = @purchase.purchase_items.find(params[:id])
    product = @purchase_item.product

    to_discount = @purchase_item.total_price

    @purchase.update!(total_price: @purchase.total_price - to_discount)
    @purchase_item.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("product_#{product.id}", partial: 'products/product', locals: { product: product }),
          turbo_stream.update("total_price", partial: 'layouts/total_price', locals: { purchase: @purchase })
        ]
      end
      format.html { redirect_to products_path, notice: 'Product removed from current purchase.' }
    end
  end
end

