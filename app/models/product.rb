class Product < ActiveRecord::Base

  belongs_to :app
  has_many :subscriptions
  has_many :customers, :through => :subscriptions
  
  validates_presence_of :app_id, :identifier, :duration, :price
  validates_uniqueness_of :identifier
  validates_numericality_of :duration, :price
  
  attr_accessible :app_id, :identifier, :duration, :price
  
  DURATIONS = { 
    :week => 1.week.to_i,
    :month => 1.month.to_i,
    :year => 1.year.to_i
  }

  before_save :generate_secret_key
  
  def generate_secret_key
    self.secret_key = Digest::SHA1.hexdigest("--#{identifier}--")[0..9]
  end
  
  
end
