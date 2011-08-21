class Zone < ActiveRecord::Base
  
  has_many :records, :dependent => :delete_all

  validates :origin,
    :presence => true,
    :uniqueness => true

  validates :ttl,
    :numericality => true

  def active_or_not
    self.active ? "Yes" : "No"
  end

  RecordType::TYPES.each do |rt|
    define_method(rt.downcase.to_sym) do
      records.select{|r| r.type_id == type_id_for(rt)}
    end
  end

  def type_id_for(rt)
    RecordType::TYPES.index(rt.upcase)
  end

end
