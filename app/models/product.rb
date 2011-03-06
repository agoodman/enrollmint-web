class Product < ActiveRecord::Base

  belongs_to :user
  
  validates_presence_of :user_id, :identifier, :duration
  validates_numericality_of :duration
  
end
