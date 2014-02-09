require 'spec_helper'

describe User do
  before :each do
    @user = FactoryGirl.create(:user)
  end
    
  it "has a valid factory" do
    @user.valid?.should be_true
  end

  it "finds an existing user" do
    theid = @user.id
    expect(User.find(theid)).to eq(@user)
  end

  it "can have an associated identity" do
    identity = @user.identities.build
    identity.user_id.should eq(@user.id)
  end
end

