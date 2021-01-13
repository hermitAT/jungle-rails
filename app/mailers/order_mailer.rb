class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order, line_items)
    @order = order
    @line_items = line_items
    @products = line_items.each do |line_item|
      Product.find(line_item.product_id)
    end

    mail(to: @order.email, subject: "Order ID #{@order.id} - Confirmation")
  end
end
