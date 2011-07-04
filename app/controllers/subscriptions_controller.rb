class SubscriptionsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_subscription, :only => [ :show ]
  
  def show
    respond_to do |format|
      format.json { render :json => @subscription.to_json(:include => { :product => { :only => [:id,:identifier] }, :customer => { :only => [:id,:email] } }, :only => [ :id, :expires_on, :created_at, :updated_at ]) }
    end
  end

  def update
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  private
  
  def assign_subscription
    @subscription = Subscription.includes(:product, :customer).find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @subscription = Subscription.includes(:product, :customer).find(params[:id]) if params[:id]
  end
  
end
