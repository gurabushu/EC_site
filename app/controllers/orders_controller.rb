class OrdersController < ApplicationController

  def new
    @cart_items = current_user.cart_items.includes(:product)
    @order = Order.new
    @total_price = @cart_items.sum {|item| item.product.price.to_i * item.quantity}
  end

def create
  @cart_items = current_user.cart_items.includes(:product)
  @order = Order.new(order_params)
  @order.user = current_user
  @order.total_price = @cart_items.sum { |item| item.product.price.to_i * item.quantity }
  if @order.save
    redirect_to root_path, notice: "購入が完了しました。"
  else
    render :new
  end

  ActiveRecord::Base.transaction do
    if @order.save
      @cart_items.each do |item|
        @order.order_items.create!(
          product_id: item.product_id,
          quantity: item.quantity,
          price: item.product.price
        )
      end
      current_user.cart_items.destroy_all
      redirect_to cart_items_path, notice: "購入が完了しました。"
    else
      render :new
    end
  end
end
  private

  def order_params
    params.require(:order).permit(:note, :receiver_name, :address, :payment_method)
  end
  
end