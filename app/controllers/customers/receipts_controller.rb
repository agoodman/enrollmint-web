class Customers::ReceiptsController < ApplicationController

  before_filter :authenticate
  before_filter :can_access_customer?
  
  def create
    @receipt = Receipt.new(params[:receipt])
    # explicitly assign customer id to prevent injection
    @receipt.customer_id = @customer.id
    
    respond_to do |format|
      if @receipt.save
        format.json { head :ok }
      else
        format.json { render :json => { :errors => @receipt.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
end
