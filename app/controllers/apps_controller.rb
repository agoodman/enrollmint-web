class AppsController < ApplicationController

  before_filter :authenticate
  before_filter :assign_app, :only => [ :show, :update, :destroy ]
  before_filter :can_access_app?, :only => [ :show, :update, :destroy ]

  def index
    @apps = App.where(:user_id => current_user.id).order('title asc')
    respond_to do |format|
      format.html
      format.json { render :json => @apps.to_json(:only => [:id, :bundle_identifier, :title]) }
    end
  end

  def create
    @app = App.new(params[:app])
    # explicitly assign user id to prevent injection
    @app.user_id = current_user.id
    
    respond_to do |format|
      if @app.save
        format.html { redirect_to apps_path }
        format.json { render :json => @app }
      else
        format.html { redirect_to apps_path, :alert => @app.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @app.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @app }
    end
  end

  def update
    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to apps_path, :notice => "App updated." }
        format.json { head :ok }
      else
        format.html { redirect_to apps_path, :alert => @app.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @app.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_path, :notice => "App deleted." }
      format.json { head :ok }
    end
  end

  private
  
  def assign_app
    @app = App.find_by_secret_key(params[:secret_key]) if params[:secret_key]
    @app = App.find(params[:id]) if params[:id]
  end
  
  def can_access_app?
    unless current_user.apps.include?(@app)
      respond_to do |format|
        format.json { render :json => { :errors => ["You do not have access"] } }
      end
    end
  end

end
