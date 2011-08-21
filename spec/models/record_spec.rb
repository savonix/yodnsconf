require 'spec_helper'

describe Record do
  it "should be able to create a new record" do
    @zone = Factory.build(:zone)
    @zone.save
    r = Factory.build(:record)
    r.save
  end
end
