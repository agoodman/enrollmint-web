class Customers::ReceiptsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_customer
  before_filter :can_access_customer?
  
  def create
    @receipt = Receipt.new(params[:receipt])
    # explicitly assign customer id to prevent injection
    @receipt.customer_id = @customer.id
    
    respond_to do |format|
      if @receipt.save
        @receipt.retrieve_transaction_data(request.host=~/sandbox/)
        format.json { head :ok }
      else
        format.json { render :json => { :errors => @receipt.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  private
  
  def assign_customer
    @customer = Customer.find_by_secret_key(params[:secret_key])
  end
  
end
