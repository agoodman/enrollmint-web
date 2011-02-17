require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase

  should belong_to :customer
  should validate_presence_of :customer_id
  should validate_presence_of :receipt_data
  
end
