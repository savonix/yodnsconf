class RecordType
  include ActiveModel::Validations

  attr_accessor :id
  attr_reader :name
  TYPES = ['A', 'CNAME', 'TXT', 'NS', 'MX', 'A4', 'SRV' ]

  def name
    TYPES[id]
  end

end
