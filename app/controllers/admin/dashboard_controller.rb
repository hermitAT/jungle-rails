class Admin::DashboardController < ApplicationController
  before_filter :authorize

  def show
    @num_products = Product.count
    @num_categories = Category.count
  end
end
