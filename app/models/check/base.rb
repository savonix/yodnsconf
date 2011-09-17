class Check::Base
  include ActiveModel::Validations

  attr_accessor :resolved

  def check_name
    self.class.name.titleize
  end

  def initialize(resolved)
    @resolved = resolved
  end

end
