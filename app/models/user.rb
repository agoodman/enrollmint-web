class User < ActiveRecord::Base
  include Clearance::User

  has_many :customers
  has_many :apps
  has_many :products, :through => :apps

  validates_presence_of :first_name, :last_name, :terms_of_service_accepted, :api_token
  
  before_validation :generate_api_token
  
  private
  
  def generate_api_token
    self.api_token = Digest::SHA1.hexdigest("--#{Time.now.utc}--#{password}--#{rand}--")[0..9] if api_token.blank?
  end
  
end
