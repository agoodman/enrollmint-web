require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase

  should belong_to :subscription
  
  should validate_presence_of :subscription_id
  should validate_presence_of :transaction_id
  
  should validate_uniqueness_of :transaction_id
  
end
