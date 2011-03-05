class User < ActiveRecord::Base
  include Clearance::User

  has_many :customers

  validates_presence_of :first_name, :last_name, :terms_of_service_accepted
  
end
