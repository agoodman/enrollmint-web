require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many :customers

end
