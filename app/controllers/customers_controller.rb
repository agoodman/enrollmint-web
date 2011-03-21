class CustomersController < ApplicationController

  before_filter :authenticate
  before_filter :assign_products, :only => [ :index, :show ]
  before_filter :assign_customer, :only => [ :show, :update ]
  
  def index
    @customers = Customer.includes(:subscriptions).where(:user_id => current_user.id).order('email asc')
    respond_to do |format|
      format.html
      format.json { render :json => @customers.to_json(:only => [:id,:email]), :status => :ok }
    end
  end
  
  def create
    @customer = Customer.new(params[:customer])
    # explicitly assign user id to prevent injection
    @customer.user_id = current_user.id
    
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, :notice => "Customer created." }
        format.json { render :json => @customer, :status => :ok }
      else
        format.html { redirect_to customers_path, :alert => @customer.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @customer.to_json(:include => { :subscriptions => { :only => [ :id, :expires_on, :created_at, :updated_at ] } }) }
    end
  end
  
  def update
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to customers_path, :notice => "Customer updated." }
        format.json { head :ok }
      else
        format.html { redirect_to customers_path, :alert => @customer.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def assign_products
    @products = Product.where(:user_id => current_user.id).order('identifier asc')
  end

  def assign_customer
    @customer = Customer.find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @customer = Customer.find(params[:id]) if params[:id]
    record_not_found if @customer.nil?
  end

  def record_not_found
    respond_to do |format|
      format.html { render :file => 'public/404.html' }
      format.json { render :json => { :errors => [ "Customer does not exist." ] }, :status => :not_found }
    end
  end  
  
end
