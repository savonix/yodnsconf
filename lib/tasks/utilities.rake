namespace :utilities do


  task :echo => :environment do
    puts Rails.env
  end

  task :import => :environment do
    zonefiles = Dir.glob(File.join(Rails.root, "data", "zones", "*"))
    puts zonefiles.count
    zonefile = "data/zones/yodnsconf.com.zone"
    zonefiles.each do |zonefile|
      if File.exists?(zonefile)
        #puts Zonefile.from_file(zonefile).to_yaml
        oz = Zonefile.from_file(zonefile)
        z  = oz.soa

        z[:mbox] = z[:email]
        z[:ns] = z[:primary]
        z[:ttl] = z[:minimumTTL]
        z[:minimum] = z[:minimumTTL]
        z[:active] = 1

        %w(primary email retry refresh expire minimumTTL).each {|key| z.delete(key.to_sym)}
        zone = Zone.new(z)
        zone.save!


        RecordType::TYPES.map{|at| [at.downcase, RecordType::TYPES.index(at)]}.each do |record_type, type_id|
          oz.send(record_type.to_sym).each do |r|
            r[:type_id] = type_id
            r.delete(:class)
            zr = zone.records.build(r)
            zr.save!
          end
        end

      else
        #raise ZonefileNotFound.new(zone)
      end
    end
  end


end
