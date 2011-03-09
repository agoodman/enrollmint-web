class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery

  rescue_from(ActiveRecord::RecordNotFound) do |e|
    respond_to do |format|
      format.html { render :file => 'public/404.html' }
      format.json { render :json => { :errors => [ "Record not found" ] }, :status => :not_found }
    end
  end
  
  private
  
  def deny_access
    respond_to do |format|
      format.json { render :json => { :errors => [ "You are not authorized." ] }, :status => :unauthorized }
    end
  end
  
  def can_access_customer?
    @customer = Customer.find(params[:customer_id])
    if ! current_user.customers.include?(@customer)
      respond_to do |format|
        format.json { render :json => { :errors => [ "You do not have permission." ] }, :status => :unauthorized }
      end
    end
    
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.json { render :json => { :errors => [ "Customer does not exist." ] }, :status => :not_found }
    end
  end

end
