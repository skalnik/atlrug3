require 'spec_helper'

describe SessionsController do
  let(:uid)       { '12345' }
  let(:name)      { 'Mike Skalnik' }
  let(:auth_hash) { { 'uid' => uid, 'info' => { 'name' => name } } }
  let(:user)      { create(:user) }

  describe '#create' do
    it 'attempts to find a user by auth hash' do
      SessionsController.any_instance.stub(:auth_hash => auth_hash)
      User.should_receive(:find_by_hash).with(auth_hash)
      post :create
    end

    it 'creates a user by auth hash if one is not found' do
      SessionsController.any_instance.stub(:auth_hash => auth_hash)
      User.stub(:find_by_hash => nil)
      User.should_receive(:create_from_hash).with(auth_hash).and_return(user)
      post :create
    end

    it 'logs the user in' do
      User.stub(:find_by_hash => user)
      post :create
      session[:user_id].should == user.id
    end

    it 'redirects to root' do
      User.stub(:find_by_hash => user)
      post :create
      response.should redirect_to root_url
    end
  end
end
