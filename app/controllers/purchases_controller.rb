class PurchasesController < ApplicationController
  def purchase
    @purchase = Purchase.find(params[:id])
  end

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

  def download
    pdf = generate_pdf

    send_data(pdf.render,
              filename: "purchase_#{purchase.updated_at.strftime("%d/%m/%Y %H:%M")}.pdf",
              type: "application/pdf")
  end

  def preview
    pdf = generate_pdf

    send_data(pdf.render,
              filename: "purchase_#{purchase.updated_at.strftime("%d/%m/%Y %H:%M")}.pdf",
              type: "application/pdf",
              disposition: "inline")
  end

  private

  def generate_pdf
    pdf = Prawn::Document.new

    pdf.text "Your Purchase made on #{purchase.updated_at.strftime("%d/%m/%Y %H:%M")}", size:  20, style: :bold
    purchase.purchase_items.each do |item|
      pdf.text "* #{item.product.name} - #{item.quantity} items - $#{item.total_price.to_f.round(2)}"
    end

    pdf.text "Total Price: #{purchase.total_price.to_f.round(2)}"

    pdf
  end
end
