class WhoisRecord < ActiveRecord::Base
  belongs_to :zone

  def server
    Whois::Server.guess(zone.hostname)
  end

  def expiration
    ex = zone.whois_record.whois.expires_on.nil? ? godaddy_expiry : zone.whois_record.whois.expires_on 
  end

  def godaddy_expiry
    lines = whois.content.split("\n")
    exp = lines.select{|x| x.include?('Expiration')}
    return '' unless exp.present? 
    dt = exp.first.split(" ").last
    Date.parse(dt).to_s
  end

  def whois
    Whois::Record.new(server, YAML.load(record))
  end

end
