class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      render 'new'
    end
  end

  def new
    @product = Product.new
  end

  def update
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image)
  end
end
