#!/usr/bin/ruby1.9.1
require 'zonefile'
require 'json'

zf = Zonefile.from_file('data/zones/example.com.zone')

puts "Record Time To Live: #{zf.soa[:ttl]}"

puts "SOA: #{zf.soa.to_json}"
puts "A: #{zf.a.to_json}"
puts "CNAME: #{zf.cname.to_json}"
puts "NS: #{zf.ns.to_json}"
puts "TXT: #{zf.txt.to_json}"
puts "SRV: #{zf.srv.to_json}"
puts "A4: #{zf.a4.to_json}"
puts "MX: #{zf.mx.to_json}"
