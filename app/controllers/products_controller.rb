class ProductsController < ApplicationController
  before_action :get_child
  
  def index
    @products = Product.all.order(:age_low_weeks)
  end

  def show
    @product = Product.find(params[:id])
  end
end
