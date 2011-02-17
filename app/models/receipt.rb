class Receipt < ActiveRecord::Base

  belongs_to :customer
  
  validates_presence_of :customer_id, :receipt_data
  
end
