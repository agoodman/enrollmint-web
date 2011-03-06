require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many :customers
  should have_many :products

  should validate_presence_of :first_name
  should validate_presence_of :last_name
  should validate_presence_of :terms_of_service_accepted

end
