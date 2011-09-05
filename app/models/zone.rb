class Zone < ActiveRecord::Base
  
  has_many :records, :dependent => :destroy

  validates :origin,
    :presence => true,
    :uniqueness => true

  validates :ttl,
    :numericality => true

  class << self
    def total(reload=false)
      @total = nil if reload
      @total || Zone.all.count
    end
    def per_page 
      10
    end
  end

  def active_or_not
    self.active ? "Yes" : "No"
  end

  def wwwhost
    "http://www.#{origin.gsub(/\.$/,'')}/"
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
