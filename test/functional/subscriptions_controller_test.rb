require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
      @product = Factory(:product, :user => @user)
      sign_out
    end
    
    context "on get show by secret key as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        get :show, :format => 'json', :secret_key => @subscription.secret_key
      end
      
      should respond_with :unauthorized
    end

    context "on put update by secret key as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        put :update, :format => 'json', :secret_key => @subscription.secret_key, :subscription => Factory.attributes_for(:subscription)
      end
      
      should respond_with :unauthorized
    end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
      @product = Factory(:product, :user => @user)
      sign_in_as @user
    end
    
    context "on get show by secret key as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        get :show, :format => 'json', :secret_key => @subscription.secret_key
      end
      
      should respond_with :success
    end
    
    context "on put update by secret key as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        put :update, :format => 'json', :secret_key => @subscription.secret_key, :subscription => Factory.attributes_for(:subscription)
      end
      
      should respond_with :success
    end
  end

end
