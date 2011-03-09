require 'test_helper'

class Customers::SubscriptionsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
      @product = Factory(:product, :user => @user)
      sign_out
    end
    
    context "on get index as json" do
      setup do
        get :index, :format => 'json', :customer_id => @customer.id
      end
      
      should respond_with :unauthorized
    end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer_id => @customer.id, :subscription => Factory.attributes_for(:subscription, :customer_id => @customer.id, :product_id => @product.id)
      end
      
      should respond_with :unauthorized
    end
    
    context "on get show as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        get :show, :format => 'json', :customer_id => @customer.id, :id => @subscription.id
      end
      
      should respond_with :unauthorized
    end

    context "on put update as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        put :update, :format => 'json', :customer_id => @customer.id, :id => @subscription.id, :subscription => Factory.attributes_for(:subscription)
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
    
    context "on get index as json" do
      setup do
        get :index, :format => 'json', :customer_id => @customer.id
      end
      
      should respond_with :success
      should assign_to :subscriptions
    end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer_id => @customer.id, :subscription => Factory.attributes_for(:subscription, :customer_id => @customer.id, :product_id => @product.id)
      end
      
      should respond_with :success
    end
    
    context "on get show as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        get :show, :format => 'json', :customer_id => @customer.id, :id => @subscription.id
      end
      
      should respond_with :success
    end
    
    context "on put update as json" do
      setup do
        @subscription = Factory(:subscription, :customer => @customer, :product => @product)
        put :update, :format => 'json', :customer_id => @customer.id, :id => @subscription.id, :subscription => Factory.attributes_for(:subscription)
      end
      
      should respond_with :success
    end
  end

end
