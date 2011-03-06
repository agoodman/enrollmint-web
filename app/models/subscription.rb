class Subscription < ActiveRecord::Base

  belongs_to :customer
  belongs_to :product
  
  validates_presence_of :customer_id, :product_id, :expires_on
  
end
