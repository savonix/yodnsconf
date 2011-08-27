class Record < ActiveRecord::Base
  belongs_to :zone
  validates_numericality_of :ttl
  validates_numericality_of :type_id

  def record_type
    RecordType::TYPES[type_id]
  end

  def type
    record_type
  end

  def display_name
    "#{name}.#{zone.origin}"
  end

  def bare_record
    self.attributes.delete_if {|k,v| k == :id || k == :zone_id}
  end

end
