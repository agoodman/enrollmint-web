require 'test_helper'

class CourierTest < ActiveSupport::TestCase
  
  should validate_presence_of :post_back_url
  should validate_presence_of :subscription_id
  
end
