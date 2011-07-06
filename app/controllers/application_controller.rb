class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  private
  
  def deny_access
    respond_to do |format|
      format.html { redirect_to sign_in_path, :alert => "You are not signed in." }
      format.json { render :json => { :errors => [ "You are not authorized." ] }, :status => :unauthorized }
    end
  end

  def assign_app
    @app = App.find_by_bundle_identifier(params[:bundle_identifier])
  end
  
  def assign_customer
    @customer = Customer.find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @customer = Customer.find(params[:customer_id]) if params[:customer_id]
  end
  
  def can_access_customer?
    if ! current_user.customers.include?(@customer)
      respond_to do |format|
        format.html { redirect_to app_customers_path(@app), :alert => "You do not have permission." }
        format.json { render :json => { :errors => [ "You do not have permission." ] }, :status => :unauthorized }
      end
    end
  end

  def record_not_found
    respond_to do |format|
      format.html { render :file => 'public/404.html' }
      format.json { render :json => { :errors => [ "Record not found" ] }, :status => :not_found }
    end
  end

end
