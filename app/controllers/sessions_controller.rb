class SessionsController < Clearance::SessionsController

  private
  
  def url_after_create
    products_path
  end
  
end
