namespace :utilities do


  task :echo => :environment do
    puts Rails.env
  end

  task :import => :environment do
    Zone.all.each {|z| z.delete}
    zonefiles = Dir.glob(File.join(Rails.root, "data", "zones", "*.zone"))
    puts zonefiles.count
    zonefiles.each do |zonefile|
      if File.exists?(zonefile)
        #puts Zonefile.from_file(zonefile).to_yaml
        oz = Zonefile.from_file(zonefile)
        z  = oz.soa

        z[:ttl] = z[:minimumTTL]
        z[:active] = 1

        %w(retry refresh expire).each {|key| z.delete(key.to_sym)}
        zone = Zone.new(z)
        unless zone.save
          puts zonefile
        end


        RecordType::TYPES.map{|at| [at.downcase, RecordType::TYPES.index(at)]}.each do |record_type, type_id|
          oz.send(record_type.to_sym).each do |r|
            r[:type_id] = type_id
            r.delete(:class)
            zr = zone.records.build(r)
            zr.save!
          end
        end

      end
    end
  end

  task :export => :environment do
    Zone.all.each do |z|
      target = File.new(File.join(Rails.root, "tmp", "zones", "#{z.origin}.zone"))
      Zonefile.new(z.output, target, z.origin)
    end

  end

end
