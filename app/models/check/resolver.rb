class Check::Resolver
  attr_accessor :ns_records, :a_records, :mx_records

  def initialize(hostname)
    Dnsruby::DNS.open do |dns|
      @ns_records = dns.getresources(hostname, Dnsruby::Types.NS).map do |r|
        rns = dns.getaddress(r.nsdname.to_s).to_s
        p = Net::Ping::External.new(rns).ping?
        [r.nsdname.to_s, rns, r.ttl, p]
      end
      @a_records = dns.getresources("www.#{hostname}", Dnsruby::Types.A).map { |r| r.name.to_s}
      @mx_records = dns.getresources(hostname, Dnsruby::Types.MX).map { |r| r.name.to_s}
    end
  end

end
