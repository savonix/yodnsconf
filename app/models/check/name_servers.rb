class Check::NameServers < Check::Base

  def check_results
    @resolved.ns_records.sort
  end

  def check_pass
    pass = @resolved.ns_records.count > 1 ? true : false
    return pass
  end

end
