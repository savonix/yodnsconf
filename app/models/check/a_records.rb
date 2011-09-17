class Check::ARecords < Check::Base

  def check_results
    @resolved.a_records
  end

  def check_pass
  end

end
