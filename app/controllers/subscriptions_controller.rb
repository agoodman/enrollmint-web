class SubscriptionsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_subscription, :only => [ :show ]
  
  def show
    respond_to do |format|
      format.json { render :json => @subscription.to_json }
    end
  end

  def update
    respond_to do |format|
      format.json { head :ok }
    end
  end
  
  private
  
  def assign_subscription
    @subscription = Subscription.find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @subscription = Subscription.find(params[:id]) if params[:id]
  end
  
end
