class UsersController < Clearance::UsersController

  before_filter :authenticate, :except => :create
  
  def show
    @user = current_user
    
    respond_to do |format|
      format.json { render :json => @user }
    end
  end
  
  def update
    @user = current_user
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { render :json => { :errors => @user.errors.full_messages }, :status => :unprocessable_entity }
      else
        head :ok
      end
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy

    head :ok
  end

end
