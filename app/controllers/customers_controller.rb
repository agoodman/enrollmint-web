class CustomersController < ApplicationController

  before_filter :authorize
  before_filter :assign_app
  before_filter :assign_customer, :only => [ :show, :update ]
  
  def index
    @customers = Customer.where(:user_id => current_user.id).order('email asc')
    respond_to do |format|
      format.html
      format.json { render :json => @customers.to_json(:only => [:id,:email]), :status => :ok }
      format.xml { render :xml => @customers.to_xml(:only => [:id,:email]), :status => :ok }
    end
  end
  
  def create
    @customer = Customer.new(params[:customer])
    # explicitly assign user id to prevent injection
    @customer.user_id = current_user.id
    
    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path(:bundle_identifier => @app.bundle_identifier), :notice => "Customer created." }
        format.json { render :json => @customer, :status => :ok }
        format.xml { render :xml => @customer, :status => :ok }
      else
        format.html { redirect_to customers_path(:bundle_identifier => @app.bundle_identifier), :alert => @customer.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    options = { 
      :only => [ :id, :email ], 
      :include => { 
        :subscriptions => { 
          :include => { 
            :product => { :except => :secret_key } 
          }, 
          :except => :secret_key 
        } 
      }
    }
    respond_to do |format|
      format.html
      format.json { render :json => @customer.to_json(options), :status => :ok }
      format.xml { render :xml => @customer.to_xml(options), :status => :ok }
    end
  end
  
  def update
    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to customers_path(:bundle_identifier => @app.bundle_identifier), :notice => "Customer updated." }
        format.json { head :ok }
        format.xml { head :ok }
      else
        format.html { redirect_to customers_path(:bundle_identifier => @app.bundle_identifier), :alert => @customer.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @customer.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  
  def assign_customers
    @customers = Product.where(:user_id => current_user.id).order('identifier asc')
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
      format.xml { render :xml => { :errors => [ "Customer does not exist." ] }, :status => :not_found }
    end
  end  
  
end
