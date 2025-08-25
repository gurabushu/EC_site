class UsersController < ApplicationController

  def index
    @products = Product.all
    @search_query = params[:q]
    if @search_query.present?
      @products = Product.where("name LIKE ?", "%#{@search_query}%")
    else
      @products = Product.all
    end
  end


  def show
    @user = User.find(params[:id])
  end

end