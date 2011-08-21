require 'spec_helper'

describe ZonesController do

  before(:each) do
    @user = Factory.create(:valid_user)
    sign_in @user
  end

  before(:all) do
    @zone = Factory.build(:zone)
    @zone.save
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', {:id => 1}
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit', {:id => 1}
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  after(:all) do
    @zone.delete
  end

end
