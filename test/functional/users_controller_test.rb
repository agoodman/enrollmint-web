require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  context "when not signed in" do
    setup do
      @user = Factory(:user)
      sign_out
    end
    
    context "on post create as json" do
      setup do
        post :create, :format => 'json', :user => Factory.attributes_for(:user)
      end
      
      should respond_with :success
    end
    
    context "on get show as json" do
      setup do
        get :show, :format => 'json'
      end
      
      should respond_with :unauthorized
    end
    
    context "on put update as json" do
      setup do
        put :update, :format => 'json', :user => Factory.attributes_for(:user)
      end
      
      should respond_with :unauthorized
    end

    context "on delete destroy as json" do
      setup do
        delete :destroy, :format => 'json'
      end
      
      should respond_with :unauthorized
    end
  end

  context "when signed in" do
    setup do
      @user = Factory(:user)
      sign_in_as @user
    end
    
    context "on get show as json" do
      setup do
        get :show, :format => 'json'
      end
      
      should respond_with :success
    end
    
    context "on put update as json" do
      setup do
        put :update, :format => 'json', :user => Factory.attributes_for(:user)
      end
      
      should respond_with :success
    end
    
    context "on delete destroy as json" do
      setup do
        delete :destroy, :format => 'json'
      end
      
      should respond_with :success
    end
  end

end
