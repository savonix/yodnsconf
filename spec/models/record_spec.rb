require 'spec_helper'

describe Record do
  it "should not be able to create an invalid record" do
    @zone = Factory.build(:zone)
    @zone.save
    r = Factory.build(:record)
    r.ttl = "helo"
    r.save
    r.should_not be_valid
  end
  it "should be able to create a new record" do
    @zone = Factory.build(:zone)
    @zone.save
    r = Factory.build(:record)
    r.save
  end
  it "should be able to delete a record" do
    @zone = Factory.build(:zone)
    @zone.save
    r = Factory.build(:record)
    r.save
    r.destroy
  end
end
