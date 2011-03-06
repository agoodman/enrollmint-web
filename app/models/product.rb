class Product < ActiveRecord::Base

  belongs_to :user
  
  validates_presence_of :user_id, :identifier, :duration
  validates_uniqueness_of :identifier
  validates_numericality_of :duration
  
  DURATIONS = { :day => 1.day.to_i,
    :week => 1.week.to_i,
    :month => 1.month.to_i,
    :year => 1.year.to_i
  }
  
end
