class OrdersController < ApplicationController

  def new
    @product = Product.find(params[:product_id])
    @order = Order.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params.merge(product: @product))
    if @order.save
      redirect_to product_path(@product), notice: "購入が完了しました。"
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:quantity, :note)
  end
  
end