require 'net/http'

class Subscription < ActiveRecord::Base

  belongs_to :customer
  belongs_to :product
  
  validates_presence_of :customer_id, :product_id, :expires_on
  
  attr_accessible :customer_id, :product_id, :expires_on
  
  before_create :generate_secret_key
  after_save :post_back
  
  # private

  def product_identifier
    product.identifier
  end
  
  def generate_secret_key
    self.secret_key = Digest::SHA1.hexdigest("--#{product.identifier}--#{customer.email}--")[0..9]
  end

  def post_back
    unless product.app.post_back_url.blank?
      if false # product.app.user.sync_post_back?
        synchronous_post_back
      else
        asynchronous_post_back
      end
    end    
  end
  
  def synchronous_post_back
    unless product.app.post_back_url.blank?
      herald = Herald.new
      herald.post_back_url = product.app.post_back_url
      herald.subscription_ids = [ id ]
      herald.run
    end
  end
  
  def asynchronous_post_back
    unless product.app.post_back_url.blank?
      herald = Herald.new
      herald.post_back_url = product.app.post_back_url
      herald.subscription_ids = [ id ]
      herald.queue(:priority => 2)
    end
  end
  
end
