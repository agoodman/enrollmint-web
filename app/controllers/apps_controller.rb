class AppsController < ApplicationController

  before_filter :authorize
  before_filter :assign_app, :only => [ :show, :update, :destroy ]
  before_filter :can_access_app?, :only => [ :show, :update, :destroy ]

  def index
    @apps = App.where(:user_id => current_user.id).order('title asc')
    respond_to do |format|
      format.html
      format.json { render :json => @apps.to_json(:only => [:id, :bundle_identifier, :title]) }
      format.xml { render :xml => @apps.to_xml(:only => [:id, :bundle_identifier, :title]) }
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
        format.xml { render :xml => @app }
      else
        format.html { redirect_to apps_path, :alert => @app.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @app.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @app.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render :json => @app }
      format.xml { render :xml => @app }
    end
  end

  def update
    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to app_path(:bundle_identifier => @app.bundle_identifier), :notice => "App updated." }
        format.json { head :ok }
        format.xml { head :ok }
      else
        format.html { redirect_to app_path(:bundle_identifier => @app.bundle_identifier), :alert => @app.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @app.errors.full_messages }, :status => :unprocessable_entity }
        format.xml { render :xml => { :errors => @app.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_path, :notice => "App deleted." }
      format.json { head :ok }
      format.xml { head :ok }
    end
  end

  private
  
  def assign_app
    @app = App.find_by_bundle_identifier(params[:bundle_identifier]) if params[:bundle_identifier]
  end
  
  def can_access_app?
    unless current_user.apps.include?(@app)
      respond_to do |format|
        format.json { render :json => { :errors => ["You do not have access"] } }
        format.xml { render :xml => { :errors => ["You do not have access"] } }
      end
    end
  end

end
