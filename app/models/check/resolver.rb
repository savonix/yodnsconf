class Check::Resolver
  attr_accessor :ns_records, :a_records

  def initialize(hostname)
    Dnsruby::DNS.open do |dns|
      @ns_records = dns.getresources(hostname, Dnsruby::Types.NS).map { |r| r.nsdname.to_s}
      @a_records = dns.getresources("www.#{hostname}", Dnsruby::Types.A).map { |r| r.name.to_s}
    end
  end

end
