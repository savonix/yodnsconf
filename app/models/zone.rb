class Zone < ActiveRecord::Base
  has_many :record

  validates :origin,
    :presence => true,
    :uniqueness => true

  validates :ttl,
    :numericality => true

  def active_or_not
    self.active ? "Yes" : "No"
  end

end
