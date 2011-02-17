class CustomersController < ApplicationController

  before_filter :authenticate
  
  def index
    @customers = current_user.customers
    respond_to do |format|
      format.json { render :json => @customers, :status => :ok }
    end
  end
  
  def create
    @customer = Customer.new(params[:customer])
    respond_to do |format|
      if @customer.save
        format.json { render :json => @customer, :status => :ok }
      else
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.json { render :json => @customer }
    end
  end
  
  def update
    @customer = Customer.find(params[:id])
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.json { head :ok }
      else
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
end
