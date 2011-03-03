require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase

  should belong_to :customer
  
  should validate_presence_of :customer_id
  should validate_presence_of :product_identifier
  should validate_presence_of :expires_on
  
end
