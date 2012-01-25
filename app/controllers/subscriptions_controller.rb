class SubscriptionsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_app
  before_filter :assign_subscription, :only => [ :show ]
  
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
    respond_to do |format|
      format.json { render :json => @subscription.to_json(:include => {:customer => { :except => :secret_key }, :product => { :except => :secret_key } }, :except => :secret_key) }
      format.xml { render :xml => @subscription.to_xml(:include => {:customer => { :except => :secret_key }, :product => { :except => :secret_key } }, :except => :secret_key) }
    end
  end

  def update
    respond_to do |format|
      if @subscription.update_attributes(params[:subscription])
        format.json { head :ok }
        format.xml { head :ok }
      else
        format.html { redirect_to app_subscriptions_path(@app), :alert => @subscription.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @subscription.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @subscription.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.json { head :ok }
      format.xml { head :ok }
    end
  end
  
  private
  
  def assign_subscription
    @subscription = Subscription.find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @subscription = Subscription.find(params[:id]) if params[:id]
  end 
  
end
