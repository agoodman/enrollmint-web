require 'test_helper'

class CustomerTest < ActiveSupport::TestCase

  should belong_to :user
  should have_many :subscriptions
  should validate_presence_of :user_id

end
