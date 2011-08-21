require 'rubygems'
require 'zonefile'

zonefile = "data/zones/yodnsconf.com.zone"
if File.exists?(zonefile)
  puts Zonefile.from_file(zonefile).to_yaml
else
  #raise ZonefileNotFound.new(zone)
end
