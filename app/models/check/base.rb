class Check::Base
  include ActiveModel::Validations

  attr_accessor :resolved

  def initialize(resolved)
    @resolved = resolved
  end

end
