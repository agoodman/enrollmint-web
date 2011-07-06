require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :subscriptions
  should have_many :products
  should validate_presence_of :user_id
  should validate_presence_of :email

end
