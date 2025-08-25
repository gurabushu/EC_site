class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product)
    @total_price = @cart_items.sum {|item| item.product.price * item.quantity}
  end

  def new
    @cart_item = CartItem.new
  end

 def create
  product = Product.find(params[:product_id])
  cart_item = current_user.cart_items.find_or_initialize_by(product_id: product.id)
  cart_item.quantity ||= 0
  cart_item.quantity += 1

  if cart_item.save
    redirect_to cart_items_path, notice: "商品をカートに追加しました"
  else
    redirect_to product_path(product), alert: "カートに追加できませんでした"
  end
end

end
