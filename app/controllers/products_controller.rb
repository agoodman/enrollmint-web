class ProductsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_app
  before_filter :assign_product, :only => [ :show, :update, :destroy ]
  before_filter :can_access_product?, :only => [ :show, :update, :destroy ]

  def index
    @products = @app.products
    respond_to do |format|
      format.html
      format.json { render :json => @products.to_json(:only => [:id, :identifier, :duration, :price]) }
      format.xml { render :xml => @products.to_xml(:only => [:id, :identifier, :duration, :price]) }
    end
  end

  def create
    @product = Product.new(params[:product])
    # explicitly assign app id to prevent injection
    @product.app_id = @app.id
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path(:bundle_identifier => @app.bundle_identifier) }
        format.json { render :json => @product }
        format.xml { render :xml => @product }
      else
        format.html { redirect_to products_path(:bundle_identifier => @app.bundle_identifier), :alert => @product.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.json { render :json => @product }
      format.xml { render :xml => @product }
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_path(:bundle_identifier => @app.bundle_identifier), :notice => "Product updated." }
        format.json { head :ok }
        format.xml { head :ok }
      else
        format.html { redirect_to products_path(:bundle_identifier => @app.bundle_identifier), :alert => @product.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @product.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_path(:bundle_identifier => @app.bundle_identifier), :notice => "Product deleted." }
      format.json { head :ok }
      format.xml { head :ok }
    end
  end

  private
  
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
