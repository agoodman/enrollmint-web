class CustomersController < ApplicationController

  before_filter :authenticate
  
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
        format.html { redirect_to @customer, :notice => "Customer created." }
        format.json { render :json => @customer, :status => :ok }
      else
        format.html { redirect_to customers_path, :alert => @customer.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @customer }
    end
  end
  
  def update
    @customer = Customer.find(params[:id])
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, :notice => "Customer updated." }
        format.json { head :ok }
      else
        format.html { redirect_to @customer, :alert => @customer.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
end
