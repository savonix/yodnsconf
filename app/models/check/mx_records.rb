class Check::MxRecords < Check::Base

  def check_results
    @resolved.mx_records
  end

  def check_pass
    check_host_name
  end

  def check_host_name
    @resolved.mx_records.none?{ |mx| /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})?$/.match(mx)}
  end
end
