require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  should belong_to :customer
  should belong_to :product
  should have_many :receipts
  
  should validate_presence_of :customer_id
  should validate_presence_of :product_id
  should validate_presence_of :expiration_date
  
end
