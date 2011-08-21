require 'spec_helper'

describe Zone do

  before(:all) do
    @zone = Factory.build(:zone)
    @zone.save
  end

  it "should be able to create a new zone" do
    @zone.should be_valid
  end

  it "should require origin to be unique" do
    zone = Zone.new(:id => 2, :origin => 'example.com.')
    zone.save
    zone.should_not be_valid
    zone.errors[:origin].should == ["has already been taken"]
  end

  it "should not update with invalid data" do
    @zone.update_attributes({:ttl => 'kasjdfkhd'})
    @zone.should_not be_valid
  end

  after(:all) do
    @zone.delete
  end

end
