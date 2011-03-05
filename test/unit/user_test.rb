require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many :customers

  should validate_presence_of :first_name
  should validate_presence_of :last_name
  should validate_presence_of :terms_of_service_accepted

end
