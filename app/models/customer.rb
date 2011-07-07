class Customer < ActiveRecord::Base

  belongs_to :user
  has_many :subscriptions
  has_many :products, :through => :subscriptions
  
  validates_presence_of :user_id, :email
  
  attr_accessible :email
  
  before_save :generate_secret_key
  
  # private
  
  def generate_secret_key
    self.secret_key = Digest::SHA1.hexdigest("--#{email}--")[0..9]
  end
  
end
