class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_AUTH_USER'], password: ENV['HTTP_AUTH_PASSWORD']

  before_filter :authorize

  def show
    @num_products = Product.count
    @num_categories = Category.count
  end
end
