class Customers::ReceiptsController < ApplicationController

  before_filter :authorize
  before_filter :assign_customer
  before_filter :can_access_customer?
  
  def create
    @receipt = Receipt.retrieve_from_itunes(@customer.id, params[:receipt_data], request.host=~/sandbox/, current_user.shared_secret)

    respond_to do |format|
      if @receipt.nil?
        format.json { render :json => { :errors => [ "Invalid receipt" ] }, :status => :unprocessable_entity }
      else    
        # explicitly assign customer id to prevent injection
        # @receipt.customer_id = @customer.id
    
        if @receipt.save
          format.json { render :json => @receipt.to_json(:include => :subscription, :except => :id) }
        else
          puts "receipt failed validation: #{@receipt.errors.full_messages}"
          format.json { render :json => { :errors => @receipt.errors.full_messages }, :status => :unprocessable_entity }
        end
      end
    end
  end

end
