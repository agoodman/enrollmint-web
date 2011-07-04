require 'net/http'

class Subscription < ActiveRecord::Base

  belongs_to :customer
  belongs_to :product
  
  validates_presence_of :customer_id, :product_id, :expires_on
  
  attr_accessible :product_id, :expires_on
  
  before_create :generate_secret_key
  after_save :synchronous_post_back
  
  # private
  
  def generate_secret_key
    self.secret_key = Digest::SHA1.hexdigest("--#{product.identifier}--#{customer.email}--")[0..9]
  end

  def synchronous_post_back
    unless product.app.post_back_url.blank?
      uri = URI.parse(product.app.post_back_url)
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
      request.body = [id].to_json
      puts "posting back to #{uri.request_uri} with body: #{request.body}"
      response = http.request(request)
    end
  end
  
end
