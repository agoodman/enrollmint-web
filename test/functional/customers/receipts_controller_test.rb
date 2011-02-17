require 'test_helper'

class Customers::ReceiptsControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
      sign_out
    end
    
    # context "on get index as json" do
    #   setup do
    #     get :index, :format => 'json', :customer_id => @customer.id
    #   end
    #   
    #   should respond_with :unauthorized
    # end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer_id => @customer.id, :receipt => Factory.attributes_for(:receipt, :customer_id => @customer.id)
      end
      
      should respond_with :unauthorized
    end
    
    # context "on get show as json" do
    #   setup do
    #     @receipt = Factory(:receipt, :customer => @customer)
    #     get :show, :format => 'json', :customer_id => @customer.id, :id => @receipt.id
    #   end
    #   
    #   should respond_with :unauthorized
    # end
    # 
    # context "on put update as json" do
    #   setup do
    #     @receipt = Factory(:receipt, :customer => @customer)
    #     put :update, :format => 'json', :customer_id => @customer.id, :id => @receipt.id, :receipt => Factory.attributes_for(:receipt)
    #   end
    #   
    #   should respond_with :unauthorized
    # end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      @customer = Factory(:customer, :user => @user)
      sign_in_as @user
    end
    
    # context "on get index as json" do
    #   setup do
    #     get :index, :format => 'json', :customer_id => @customer.id
    #   end
    #   
    #   should respond_with :success
    #   should assign_to :receipts
    # end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :customer_id => @customer.id, :receipt => Factory.attributes_for(:receipt, :customer_id => @customer.id)
      end
      
      should respond_with :success
    end
    
    # context "on get show as json" do
    #   setup do
    #     @receipt = Factory(:receipt, :customer => @customer)
    #     get :show, :format => 'json', :customer_id => @customer.id, :id => @receipt.id
    #   end
    #   
    #   should respond_with :success
    # end
    # 
    # context "on put update as json" do
    #   setup do
    #     @receipt = Factory(:receipt, :customer => @customer)
    #     put :update, :format => 'json', :customer_id => @customer.id, :id => @receipt.id, :receipt => Factory.attributes_for(:receipt)
    #   end
    #   
    #   should respond_with :success
    # end
  end

end
