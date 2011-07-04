require 'test_helper'

class AppsControllerTest < ActionController::TestCase

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
        post :create, :format => 'json', :app => Factory.attributes_for(:app, :user_id => @user.id)
      end

      should respond_with :unauthorized
    end

    context "on get show as json" do
      setup do
        @app = Factory(:app, :user => @user)
        get :show, :format => 'json', :id => @app.id
      end

      should respond_with :unauthorized
    end

    context "on put update as json" do
      setup do
        @app = Factory(:app, :user => @user)
        put :update, :format => 'json', :id => @app.id, :app => Factory.attributes_for(:app)
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
      should assign_to :apps
    end

    context "on post create as json" do
      setup do
        post :create, :format => 'json', :app => Factory.attributes_for(:app, :user_id => @user.id)
      end

      should respond_with :success
      should assign_to :app
    end

    context "on get show as json" do
      setup do
        @app = Factory(:app, :user => @user)
        get :show, :format => 'json', :id => @app.id
      end

      should respond_with :success
      should assign_to :app
    end

    context "on put update as json" do
      setup do
        @app = Factory(:app, :user => @user)
        put :update, :format => 'json', :id => @app.id, :app => Factory.attributes_for(:app)
      end

      should respond_with :success
    end
  end

end
