class MainController < ApplicationController
  def home
    @number_of_sales = number_of_sales
    @best_selling_product = best_selling_product
    @total_sales_revenue = total_sales_revenue
  end

  private

  def sales
    @sales = Purchase.all.active
  end

  def number_of_sales
    sales.size
  end

  def total_sales_revenue
    sales.sum { |purchase| purchase.total_price }
  end

  def best_selling_product
    Product.all.max_by(&:units_sold)
  end
end
