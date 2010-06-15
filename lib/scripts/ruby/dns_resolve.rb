#!/usr/bin/ruby1.9.1
require 'net/dns/resolver'
require 'json'

res = Net::DNS::Resolver.new(:nameservers => "192.168.8.2", :usevc => true)
#res.use_tcp = true
#packet = res.query("intra.savonix.com", Net::DNS::TXT)
packet = res.query("zones.savonix.internal", Net::DNS::TXT)



zones = packet.answer.map do |rr|
  # Not sure why this includes an empty space at the end
  # See http://github.com/bluemonk/net-dns/blob/master/lib/net/dns/rr/txt.rb#L46
  rr.txt.rstrip
end

puts zones.to_json
