class UsersController < Clearance::UsersController

  before_filter :authorize, :except => [ :new, :create ]
  skip_before_filter :redirect_to_root
  
  def show
    @user = current_user
    
    respond_to do |format|
      format.html
      format.json { render :json => @user }
    end
  end
  
  def update
    @user = current_user
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to user_path, :notice => "User updated." }
        format.json { head :ok }
      else
        format.html { redirect_to user_path, :alert => @user.errors.full_messages.join("<br/>") }
        format.json { render :json => { :errors => @user.errors.full_messages }, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy

    head :ok
  end
  
  private
  
  def redirect_to_root
    redirect_to root_path and return
  end

end
