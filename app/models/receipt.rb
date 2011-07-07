require 'net/https'

class Receipt < ActiveRecord::Base

  belongs_to :subscription
  
  validates_presence_of :subscription_id, :transaction_id
  validates_uniqueness_of :transaction_id, :message => "has already been recorded."
  
  # fetches transaction data from iTunes Store
  def self.retrieve_from_itunes(customer_id, receipt_data, sandbox = false, secret = nil)
    unless Rails.env == 'test'
      # build request hash
      request_data = { "receipt-data" => receipt_data, "password" => secret }.to_json
    
      # retrieve transaction from iTunes
      uri = URI.parse("https://#{sandbox ? "sandbox" : "buy"}.itunes.apple.com/verifyReceipt")
      request = Net::HTTP::Post.new(uri.request_uri, {'Content-Type' => 'application/json'})
      # puts "raw request sent to itunes: #{request_data}"
      request.body = request_data
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.port == 443
      response = http.request(request)
      puts "raw response from itunes: #{response.body}"
    
      # handle response
      case response
      when Net::HTTPSuccess
        return process_response_data(customer_id, response.body)
      else
        return nil
      end
    end
  # rescue Exception => e
  #   puts "error: #{e}"
  #   return nil
    
  end
  
  def self.process_response_data(customer_id, response_json)
    response_data = ActiveSupport::JSON.decode(response_json)
    return nil unless response_data
    status = response_data['status'].to_i

    # extract receipt data
    receipt_data = response_data['receipt']
    product_identifier = receipt_data['product_id']
    quantity = receipt_data['quantity']
    transaction_id = receipt_data['transaction_id']
    purchase_date = Time.parse(receipt_data['purchase_date'])
    expiration_date = Time.at(receipt_data['expires_date'].to_i/1000)

    # lookup product
    product = Product.find_by_identifier(product_identifier)
    puts "product found with id=#{product.identifier}, duration=#{product.duration}"
    return nil unless product

    # populate receipt
    receipt = Receipt.new
    receipt.quantity = quantity
    receipt.transaction_id = transaction_id
    receipt.purchase_date = purchase_date
    receipt.expiration_date = expiration_date

    if status==21006 
      # find associated subscription
      subscription = Subscription.find_by_customer_id_and_product_id(customer_id, product.id)

      if subscription.nil?
        # create if none exists (triggers post back)
        subscription = Subscription.create(:customer_id => customer_id, :product_id => product.id, :expiration_date => expiration_date)
        receipt.subscription_id = subscription.id
        puts "subscription created expired - id: #{subscription.id},  customer_id: #{subscription.customer_id} product_id: #{subscription.product_id}, expiration_date: #{subscription.expiration_date}"
      else
        receipt.subscription_id = subscription.id
        # update expiration date (triggers post back)
        if expiration_date > subscription.expiration_date
          subscription.update_attributes(:expiration_date => expiration_date)
          puts "subscription updated expired - id: #{subscription.id},  customer_id: #{subscription.customer_id} product_id: #{subscription.product_id}, expiration_date: #{subscription.expiration_date}"
        else
          puts "subscription not updated - id: #{subscription.id},  customer_id: #{subscription.customer_id} product_id: #{subscription.product_id}, expiration_date: #{subscription.expiration_date}"
        end
      end
      
      return receipt
      
    elsif status==0
      # find associated subscription
      subscription = Subscription.find_by_customer_id_and_product_id(customer_id, product.id)

      if subscription.nil?
        # create if none exists (triggers post back)
        subscription = Subscription.create(:customer_id => customer_id, :product_id => product.id, :expiration_date => expiration_date)
        receipt.subscription_id = subscription.id
        puts "subscription created active - id: #{subscription.id},  customer_id: #{subscription.customer_id} product_id: #{subscription.product_id}, expiration_date: #{subscription.expiration_date}"
      else
        receipt.subscription_id = subscription.id
        # update expiration date (triggers post back)
        if expiration_date > subscription.expiration_date
          subscription.update_attributes(:expiration_date => expiration_date)
          puts "subscription updated active - id: #{subscription.id},  customer_id: #{subscription.customer_id} product_id: #{subscription.product_id}, expiration_date: #{subscription.expiration_date}"
        else
          puts "subscription not updated - id: #{subscription.id},  customer_id: #{subscription.customer_id} product_id: #{subscription.product_id}, expiration_date: #{subscription.expiration_date}"
        end
      end

      return receipt
    end
    
    return nil
    
  # rescue Exception => e
  #   puts "response processing failed: #{e}"
  #   return nil
  end
  
end
