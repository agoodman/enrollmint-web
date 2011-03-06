require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  should belong_to :user
  
  should validate_presence_of :user_id
  should validate_presence_of :identifier
  should validate_presence_of :duration
  should validate_uniqueness_of :identifier
  should validate_numericality_of :duration
  
end
