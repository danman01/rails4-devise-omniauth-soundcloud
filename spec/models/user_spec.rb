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

  context "from omniauth" do
    before do
      #request.env["devise.mapping"] = Devise.mappings[:user] 
      #request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:soundcloud]
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:soundcloud] = OmniAuth::AuthHash.new({
        :provider => 'soundcloud',
        :uid => '123545',
        :info => {:nickname=>"jose",:image=>"http://myimageurl.com",:name=>"billy jean"},
        :extra => {:raw_info=>{:country=>"Kazakstan",:city=>"Kazak",:uri=>"http://fakesoundcloud.com/userfaker"}}
      })
    end

    it "sets a session variable to the OmniAuth auth hash" do
      # save this for controller test
      # controller.session[:auth_hash]['uid'].should == '123545'
    end

    describe "creating a user from auth" do
      before :each do
        auth = OmniAuth.config.mock_auth[:soundcloud]
        puts auth.to_yaml
        @user = User.create_user_from_omniauth(auth)
      end
      it "fails to create a new user from omniauth auth hash with no email" do
        @user.valid?.should be_false # it needs an email
      end
      it "succeeds at create a new user from omniauth auth hash with email" do
        @user.email = Faker::Internet.email
        @user.valid?.should be_true # it needs an email
      end

      it "applies auth attributes to the new user" do
        @user.username.should eq("jose")
      end

    end
  end
end

