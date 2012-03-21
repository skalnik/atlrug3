require 'spec_helper'

describe User do
  let(:uid)       { '12345' }
  let(:name)      { 'Mike Skalnik' }
  let(:auth_hash) { { 'uid' => uid, 'info' => { 'name' => name } } }

  context "validations" do
    it "is invalid if it has a non-unique uid" do
      user1 = create(:user, :uid => uid)
      user2 = build(:user, :uid => uid)
      user2.should_not be_valid
    end

    it "is invalid if the user is not part of the ATLRUG owners team"
  end

  describe ".find_by_hash" do
    it "finds a user by uid" do
      User.should_receive(:find_by_uid).with(uid)
      User.find_by_hash(auth_hash)
    end
  end

  describe ".create_from_hash" do
    it "creates a new user with parameters given" do
      User.should_receive(:create).with(:name => name, :uid => uid)
      User.create_from_hash(auth_hash)
    end
  end
end
