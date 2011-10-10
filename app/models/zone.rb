class Zone < ActiveRecord::Base
  
  has_many :records, :dependent => :destroy
  has_one :whois_record, :dependent => :destroy
  belongs_to :user, :include => :whois_record

  validates :origin,
    :presence => true,
    :uniqueness => true

  validates_format_of :origin,
    :with => /^[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\.?$/

  validates :ttl,
    :numericality => true

  attr_accessor :resolved


  class << self
    def total(reload=false)
      @total = nil if reload
      @total || Zone.all.count
    end
    def user(user_id)
      where(:user_id => user_id)
    end
    def per_page 
      10
    end
    def expired
      Zone.all.select{|x| x.expires_at.nil?}.count
    end
    def fresh
      Zone.all.reject{|x| x.expires_at.nil? || x.expires_at < Date.today + 1.week}
    end
    def checks
      [:resolve_ns_records, :resolve_www_hosts, :resolve_mx_records]
    end
  end

  def active_or_not
    self.active ? "Yes" : "No"
  end

  def hostname
    origin.gsub(/\.$/,'')
  end

  def resolve_ns_records
    @resolved = Check::Resolver.new(origin)
    Check::NameServers.new(@resolved) 
  end

  def resolve_www_hosts
    Check::ARecords.new(@resolved) 
  end

  def resolve_mx_records
    Check::MxRecords.new(@resolved) 
  end

  def wwwhost
    "http://www.#{hostname}/"
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
