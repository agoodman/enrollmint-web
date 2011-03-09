require 'test_helper'

class CustomersControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "on get index as json" do
      setup do
        get :index, :format => 'json'
      end
      
      should respond_with :unauthorized
    end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer => Factory.attributes_for(:customer, :user_id => @user.id)
      end
      
      should respond_with :unauthorized
    end
    
    context "on get show as json" do
      setup do
        @customer = Factory(:customer, :user => @user)
        get :show, :format => 'json', :id => @customer.id
      end
      
      should respond_with :unauthorized
    end

    context "on put update as json" do
      setup do
        @customer = Factory(:customer, :user => @user)
        put :update, :format => 'json', :id => @customer.id, :customer => Factory.attributes_for(:customer)
      end
      
      should respond_with :unauthorized
    end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "on get index as json" do
      setup do
        get :index, :format => 'json'
      end
      
      should respond_with :success
      should assign_to :customers
    end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer => Factory.attributes_for(:customer, :user_id => @user.id)
      end
      
      should respond_with :success
      should assign_to :customer
    end
    
    context "on get show as json" do
      setup do
        @customer = Factory(:customer, :user => @user)
        get :show, :format => 'json', :id => @customer.id
      end
      
      should respond_with :success
      should assign_to :customer
    end
    
    context "on get show by secret key as json" do
      setup do
        @customer = Factory(:customer, :user => @user)
        get :show, :format => 'json', :secret_key => @customer.secret_key
      end
      
      should respond_with :success
      should assign_to :customer
    end
    
    context "on put update as json" do
      setup do
        @customer = Factory(:customer, :user => @user)
        put :update, :format => 'json', :id => @customer.id, :customer => Factory.attributes_for(:customer)
      end
      
      should respond_with :success
    end
  end
  
end
