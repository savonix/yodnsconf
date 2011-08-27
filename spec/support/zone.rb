Factory.define :zone, :class => Zone do |f|

  f.id 1
  f.origin 'example.com.'
  f.ttl 14400
  f.email 'support@example.com'
  f.primary 'ns.example.net'

end
