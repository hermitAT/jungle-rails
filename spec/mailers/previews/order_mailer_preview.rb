# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  def order_email
    @order = Order.first
    @line_items = @order.line_items
    OrderMailer.order_email(@order, @line_items)
  end
end
