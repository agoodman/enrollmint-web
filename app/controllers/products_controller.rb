class ProductsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_app, :only => [ :index, :create, :update, :destroy ]
  before_filter :assign_product, :only => [ :show, :update, :destroy ]
  before_filter :can_access_product?, :only => [ :show, :update, :destroy ]

  def index
    @products = Product.where(:user_id => current_user.id).order('identifier asc')
    respond_to do |format|
      format.html
      format.json { render :json => @products.to_json(:only => [:id, :identifier, :duration, :price]) }
    end
  end

  def create
    @product = Product.new(params[:product])
    # explicitly assign user id to prevent injection
    @product.user_id = current_user.id
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to app_products_path(@app) }
        format.json { render :json => @product }
      else
        format.html { redirect_to app_products_path(@app), :alert => @product.errors.full_messages.join("<br/>") }
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
        format.html { redirect_to app_products_path(@app), :notice => "Product updated." }
        format.json { head :ok }
      else
        format.html { redirect_to app_products_path(@app), :alert => @product.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to app_products_path(@app), :notice => "Product deleted." }
      format.json { head :ok }
    end
  end

  private
  
  def assign_app
    @app = App.find(params[:app_id])
  end
  
  def assign_product
    @product = Product.find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @product = Product.find(params[:id]) if params[:id]
  end
  
  def can_access_product?
    unless current_user.products.include?(@product)
      respond_to do |format|
        format.json { render :json => { :errors => ["You do not have access"] } }
      end
    end
  end
  
end
