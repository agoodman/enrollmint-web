class SessionsController < Clearance::SessionsController

  private
  
  def url_after_create
    apps_path
  end
  
end
