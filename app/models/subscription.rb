require 'net/http'

class Subscription < ActiveRecord::Base

  belongs_to :customer
  belongs_to :product
  has_many :receipts
  
  validates_presence_of :customer_id, :product_id, :expiration_date
  
  attr_accessible :customer_id, :product_id, :expiration_date
  
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
      if true # product.app.user.sync_post_back?
        synchronous_post_back
      else
        asynchronous_post_back
      end
    end    
  end
  
  def synchronous_post_back
    unless product.app.post_back_url.blank?
      Delayed::Job.enqueue Courier.create!(:post_back_url => product.app.post_back_url, :subscription_id => id)
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
