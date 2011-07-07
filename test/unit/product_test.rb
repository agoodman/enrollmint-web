require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  should belong_to :app
  should have_many :subscriptions
  should have_many :customers
  
  should validate_presence_of :app_id
  should validate_presence_of :identifier
  should validate_presence_of :duration
  should validate_presence_of :price
  should validate_uniqueness_of :identifier
  should validate_numericality_of :duration
  should validate_numericality_of :price
  
end
