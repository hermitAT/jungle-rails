class Admin::DashboardController < ApplicationController

  def show
    @num_products = Product.count
    @num_categories = Category.count
    @category = Category.first
  end
end
