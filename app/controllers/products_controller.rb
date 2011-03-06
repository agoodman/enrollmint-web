class ProductsController < ApplicationController

  before_filter :authenticate
  before_filter :can_access_product?, :only => [ :show, :update, :destroy ]

  def index
    @products = current_user.products
    respond_to do |format|
      format.json { render :json => @products }
    end
  end

  def create
    @product = Product.new(params[:product])
    # explicitly assign user id to prevent injection
    @product.user_id = current_user.id
    
    respond_to do |format|
      if @product.save
        format.json { render :json => @product }
      else
        format.json { render :json => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.json { render :json => @product }
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.json { head :ok }
      else
        format.json { render :json => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.json { head :ok }
    end
  end

  private
  
  def can_access_product?
    @product = Product.find(params[:id])
    unless current_user.products.include?(@product)
      respond_to do |format|
        format.json { render :json => { :errors => ["You do not have access"] } }
      end
    end
  end
  
end
