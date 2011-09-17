class Check::NameServers < Check::Base

  def check_name
    self.class.name.titleize
  end

  def check_results
    @resolved.ns_records
  end

  def check_pass
    pass = @resolved.ns_records.count > 2 ? true : false
    return pass
  end

end
