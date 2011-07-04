class Customers::ProductsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_customer
  before_filter :can_access_customer?
  
  def index
    @products = @customer.products
    respond_to do |format|
      format.json { render :json => @products }
    end
  end
  
  # def create
  #   @product = Product.find(params[:product][:id])
  #   
  # end
  # 
  # def show
  #   @product = Product.find(params[:id])
  #   respond_to do |format|
  #     format.json { render :json => @product }
  #   end
  # end
  

end
