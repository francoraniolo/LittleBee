class PurchasesController < ApplicationController
  def show
    @purchase = Purchase.find(params[:id])
  end

  def register_sale
    @purchase = current_user.current_purchase

    if @purchase.update(active: true)
      redirect_to purchase_path(@purchase), notice: 'Sale registered successfully.'
    else
      redirect_to products_path, alert: 'Failed to register sale.'
    end
  end
end
