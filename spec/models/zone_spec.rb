require 'spec_helper'

describe Zone do

  context "when working with zones" do
    let(:zone) { Factory.create(:zone) }

    it { should be_valid }
    it { should respond_to :records }
  end

  it "should require origin to be unique" do
    zone = Zone.new(:id => 2, :origin => 'example.com.')
    zone.save
    zone.should_not be_valid
    zone.errors[:origin].should == ["has already been taken"]
  end

#  it "should not update with invalid data" do
#    @zone.update_attributes({:ttl => 'kasjdfkhd'})
#    @zone.should_not be_valid
#  end


end
