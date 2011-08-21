class Record < ActiveRecord::Base
  belongs_to :zone
  validates_numericality_of :ttl


end
