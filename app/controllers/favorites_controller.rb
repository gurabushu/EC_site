class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.includes(:product)
    @favorite_count = @favorites.size
  end

  def create
    product  = Product.find(params[:product_id])
    favorite = current_user.favorites.find_or_initialize_by(product_id: product.id)

    if favorite.new_record? && favorite.save
      redirect_to product_path(product), notice: "商品をお気に入りに追加しました"
    else
      # 既にある or 保存失敗
      msg = favorite.persisted? ? "すでにお気に入りに追加されています" : "お気に入りに追加できませんでした"
      redirect_to product_path(product), alert: msg
    end
  end

  def destroy
    product  = Product.find(params[:product_id])
    favorite = current_user.favorites.find_by(product_id: product.id)

    if favorite&.destroy
      redirect_to product_path(product), notice: "商品をお気に入りから削除しました"
    else
      redirect_to product_path(product), alert: "お気に入りから削除できませんでした"
    end
  end
end