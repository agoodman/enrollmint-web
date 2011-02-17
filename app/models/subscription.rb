class Subscription < ActiveRecord::Base

  belongs_to :customer
  
  validates_presence_of :customer_id, :product_identifier, :expires_on
  
end
