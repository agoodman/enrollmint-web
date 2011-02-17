class Customer < ActiveRecord::Base

  belongs_to :user
  has_many :subscriptions
  has_many :receipts
  
  validates_presence_of :user_id
  
end
