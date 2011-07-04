class App < ActiveRecord::Base

  belongs_to :user
  has_many :products
  
  validates_presence_of :user_id, :title, :bundle_identifier

end
