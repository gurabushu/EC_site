# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]


  def index
    @cart_items = current_user.cart_items.includes(:product)
    @total_price = @cart_items.sum { |item| item.product.price.to_i * item.quantity }
  end

  def new
    @cart_item = CartItem.new
  end

  def create
    product   = Product.find(params[:product_id])
    cart_item = current_user.cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity ||= 0
    cart_item.quantity += 1

    if cart_item.save
      redirect_to cart_items_path, notice: "商品をカートに追加しました"
    else
      redirect_to product_path(product), alert: "カートに追加できませんでした"
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path, notice: "カートの内容を更新しました"
    else
      redirect_to cart_items_path, alert: "カートの内容を更新できませんでした"
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path, notice: "商品をカートから削除しました"
  end

  private

  def set_cart_item
    # 自分のカートのレコードだけ取得（不正アクセス防止）
    @cart_item = current_user.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

  
end