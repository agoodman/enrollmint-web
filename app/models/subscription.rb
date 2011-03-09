class Subscription < ActiveRecord::Base

  belongs_to :customer
  belongs_to :product
  
  validates_presence_of :customer_id, :product_id, :expires_on
  
  attr_accessible :product_id, :expires_on
  
  before_create :generate_secret_key
  
  # private
  
  def generate_secret_key
    self.secret_key = Digest::SHA1.hexdigest("--#{product.identifier}--#{customer.email}--")[0..9]
  end
  
end
