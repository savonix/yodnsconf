require 'spec_helper'

describe User do
  before(:all) do
    @user = Factory.build(:valid_user)
    @user.save
  end
  it "should be able to create a new user" do
    @user.should be_valid
  end
end
