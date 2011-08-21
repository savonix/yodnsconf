Factory.define :zone, :class => Zone do |f|

  f.id 1
  f.origin 'example.com.'
  f.ttl 14400
  f.mbox 'support@example.com'
  f.ns 'ns.example.net'

end
