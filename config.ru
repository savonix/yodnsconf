if ENV['RACK_ENV'] == "demo"
  mountpath = '/demo/yodnsconf/'
  dirpfx = '/var/www/dev/yodnsconf/current'
elsif ENV['RACK_ENV'] == "development"
  mountpath = '/dev/'
  dirpfx = '/var/www/dev/yodnsconf'
else
  mountpath = '/'
end

require 'yodnsconf'

map mountpath do
  ccf = 'config/customconf.json'
  conf = { :uripfx => mountpath.gsub(/^\/$/,''), :ccf => ccf }
  myapp = Yodnsconf.new(conf)
  run myapp
end
