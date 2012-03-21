require 'spec_helper'

describe User do
  let(:uid)       { '12345' }

  context "validations" do
    it "is invalid if it has a non-unique uid" do
      user1 = Factory.create(:user, :uid => uid)
      user2 = Factory.build(:user, :uid => uid)
      user2.should_not be_valid
    end
  end
end
