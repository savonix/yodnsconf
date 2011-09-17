class Check::MxRecords < Check::Base

  def check_results
    @resolved.mx_records
  end

  def check_pass
  end

end
