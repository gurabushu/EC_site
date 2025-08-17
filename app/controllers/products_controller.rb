class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def create
    @product = Product.new(params.require(:product).permit(:title, :price, :description, :stock, :is_blank))
      if @product.save
        redirect_to @product, notice: '登録完了しました。'
      else
        render :new
      end
  end

  def show
    @product = Product.find(params[:id])
  end

  