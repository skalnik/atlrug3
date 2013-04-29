require 'spec_helper'

describe User do
  let(:uid)       { '12345' }
  let(:name)      { 'Mike Skalnik' }
  let(:login)     { 'skalnik' }
  let(:token)     { 'abcedf123456' }
  let(:auth_hash) {
                    { 'uid' => uid, 'info' => { 'name' => name, 'nickname' => login },
                      'credentials' => { 'token' => token } }
                  }

  context "validations" do
    it "is invalid if it has a non-unique uid" do
      user1 = create(:user, :uid => uid)
      user2 = build(:user, :uid => uid)
      user2.should be_invalid
    end
  end

  describe ".find_by_hash" do
    it "finds a user by uid" do
      User.should_receive(:find_by_uid).with(uid)
      User.find_by_hash(auth_hash)
    end
  end

  describe ".create_from_hash" do
    it "creates a new user with parameters given" do
      User.should_receive(:create).with(:name => name, :uid => uid,
                                        :github_login => login, :github_token => token)
      User.create_from_hash(auth_hash)
    end
  end

  describe "#octokit" do
    it "creates an octokit client with the users GitHub credentials" do
      user = build(:user, :github_login => login, :github_token => token)
      Octokit::Client.should_receive(:new).with(:login       => login,
                                                :oauth_token => token)
      user.octokit
    end
  end

  describe '#atlrug_team_id' do
    it "looks up the Owners team id" do
      user = build(:user)
      teams = [stub(:name => 'ATLRUGers'), stub(:name => 'Owners', :id => 1), stub(:name => 'Other')]
      octokit = stub(:org_teams => teams)
      user.stub(:octokit => octokit)
      user.atlrug_team_id.should == 1
    end

    it "doesn't raise an exception if user doesn't have permission to ATLRUG org" do
      user = build(:user)
      octokit = stub and octokit.stub(:org_teams).and_raise(Octokit::Forbidden)
      user.stub(:octokit => octokit)

      expect { user.atlrug_team_id }.to_not raise_error
    end
  end

  describe '#atlrug_organizer?' do
    let(:user) { build(:user, :uid => uid) }

    it "is true if the user is in the ATLRUG Owners team" do
      members = [stub(:id => uid + "1"), stub(:id => uid), stub(:id => uid + "10")]
      octokit = stub(:team_members => members)
      user.stub(:octokit => octokit)
      user.stub(:atlrug_team_id => 1)

      user.atlrug_organizer?.should be_true
    end

    it "is false if the user is not in the ATLRUG Owners team" do
      members = [stub(:id => uid + "1"), stub(:id => uid + "10")]
      octokit = stub(:team_members => members)
      user.stub(:octokit => octokit)
      user.stub(:atlrug_team_id)

      user.atlrug_organizer?.should be_false
    end
  end
end
