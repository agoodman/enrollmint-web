require 'test_helper'

class Customers::ProductsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
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
        post :create, :format => 'json', :customer_id => @customer.id, :product => Factory.attributes_for(:product, :user_id => @user.id)
      end
      
      should respond_with :unauthorized
    end
    
    context "on get show as json" do
      setup do
        @product = Factory(:product, :user => @user)
        get :show, :format => 'json', :customer_id => @customer.id, :id => @product.id
      end
      
      should respond_with :unauthorized
    end

    context "on put update as json" do
      setup do
        @product = Factory(:product, :user => @user)
        put :update, :format => 'json', :customer_id => @customer.id, :id => @product.id, :product => Factory.attributes_for(:product)
      end
      
      should respond_with :unauthorized
    end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
      sign_in_as @user
    end
    
    context "on get index as json" do
      setup do
        get :index, :format => 'json', :customer_id => @customer.id
      end
      
      should respond_with :success
      should assign_to :products
    end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer_id => @customer.id, :product => Factory.attributes_for(:product, :user_id => @user.id)
      end
      
      should respond_with :success
      should assign_to :product
    end
    
    context "on get show as json" do
      setup do
        @product = Factory(:product, :user => @user)
        get :show, :format => 'json', :customer_id => @customer.id, :id => @product.id
      end
      
      should respond_with :success
      should assign_to :product
    end
    
    context "on put update as json" do
      setup do
        @product = Factory(:product, :user => @user)
        put :update, :format => 'json', :customer_id => @customer.id, :id => @product.id, :product => Factory.attributes_for(:product)
      end
      
      should respond_with :success
    end
  end
  
end
