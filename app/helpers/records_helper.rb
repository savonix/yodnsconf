module RecordsHelper
  def record_type_select
    RecordType::TYPES.map{|at| [at, RecordType::TYPES.index(at)]}
  end
end
