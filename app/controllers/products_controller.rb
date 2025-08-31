class ProductsController < ApplicationController

before_action :set_product, only: [:show, :edit, :update, :destroy]

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

  def edit
    @product
  end

  def show
    @product
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: '商品を削除しました。'
  end

  def update
    if @product.update(params.require(:product).permit(:title, :price, :description, :stock, :is_blank))
      redirect_to @product, notice: '商品情報を更新しました。'
    else
      render :edit
    end
  end

  def new
    @product = Product.new
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

end

  