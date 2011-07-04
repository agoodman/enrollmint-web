require 'test_helper'

class AppTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :products
  should validate_presence_of :user_id
  should validate_presence_of :title
  should validate_presence_of :bundle_identifier
  
end
