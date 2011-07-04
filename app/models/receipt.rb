class Receipt < ActiveRecord::Base

  belongs_to :customer
  
  validates_presence_of :customer_id, :receipt_data
  validates_uniqueness_of :receipt_data
  
  # before_create :retrieve_transaction_data
  
  # private

  # fetches transaction data from iTunes Store
  def retrieve_transaction_data(sandbox = false, secret = nil)
    unless Rails.env == 'test'
      # build request hash
      request_data = { "receipt-data" => receipt_data, "password" => secret }.to_json
    
      # retrieve transaction from iTunes
      uri = URI.parse("https://#{sandbox ? "sandbox" : "buy"}.itunes.apple.com/verifyReceipt")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
      puts "raw request sent to itunes: #{request_data}"
      request.body = request_data
      response = http.request(request)
      puts "raw response from itunes: #{response.body}"
    
      # handle response
      case response
      when Net::HTTPSuccess
        return process_response_data(response.body)
      else
        return false
      end
    end
  rescue
    return false
    
  end
  
  def process_response_data(response_json)
    response_data = ActiveSupport::JSON.decode(response_json)
    return false unless response_data
    return false if response_data.status.to_i != 0
    
    # extract receipt data
    receipt = response_data.receipt
    quantity = receipt['quantity']
    product_id = receipt['product_id']
    transaction_id = receipt['transaction_id']
    purchase_date = receipt['purchase_date']
    
    # lookup product
    product = Product.find_by_identifier(product_id)
    return false unless product
    
    # find associated subscription
    subscription = Subscription.find_by_customer_id_and_product_id(customer_id, product.id)
    
    # create subscription if one is not found; update existing if found
    if subscription.nil?
      subscription = Subscription.new(:customer_id => customer_id, :product_id => product.id)
    end
    
    # update subscription expiration date
    subscription.expires_on = purchase_date + quantity * product.duration.seconds
    subscription.save
  end
  
end
