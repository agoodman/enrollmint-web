class Customers::SubscriptionsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_customer
  before_filter :can_access_customer?
  
  def index
    @subscriptions = @customer.subscriptions
    respond_to do |format|
      format.json { render :json => @subscriptions, :status => :ok }
    end
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    # explicitly assign customer id to prevent injection
    @subscription.customer_id = @customer.id
    
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @customer, :notice => "Subscription created." }
        format.json { render :json => @subscription, :status => :ok }
      else
        format.html { redirect_to @customer, :alert => @subscription.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @subscription.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @subscription = Subscription.find(params[:id])
    respond_to do |format|
      format.json { render :json => @subscription, :status => :ok }
    end
  end
  
  def update
    @subscription = Subscription.find(params[:id])
    @subscription.customer_id = @customer.id
    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.html { redirect_to @customer, :notice => "Subscription updated." }
        format.json { head :ok }
      else
        format.html { redirect_to @customer, :alert => @subscription.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @subscription.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
end
