class App < ActiveRecord::Base

  belongs_to :user
  has_many :products
  
  validates_presence_of :user_id, :title, :bundle_identifier
  validates_uniqueness_of :bundle_identifier
  
  attr_accessible :user_id, :title, :bundle_identifier

end
