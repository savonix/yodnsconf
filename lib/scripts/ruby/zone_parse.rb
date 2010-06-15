#!/usr/bin/ruby1.9.1
require 'zonefile'
require 'json'

f = ARGV[0] || 'config/example.com.zone'
zf = Zonefile.from_file(f)

puts "Record Time To Live: #{zf.soa[:ttl]}"

puts "SOA: #{zf.soa.to_json}"
puts "A: #{zf.a.to_json}"
puts "CNAME: #{zf.cname.to_json}"
puts "NS: #{zf.ns.to_json}"
puts "TXT: #{zf.txt.to_json}"
puts "SRV: #{zf.srv.to_json}"
puts "A4: #{zf.a4.to_json}"
puts "MX: #{zf.mx.to_json}"

zf.records.each do |res|
  #puts res unless res[0]==:soa
  rs = zf.send res[0].to_sym unless res[0]==:soa
  puts rs
end
