class User < ActiveRecord::Base
  validates :uid, :uniqueness => true

  class << self
    def find_by_hash(auth_hash)
      find_by_uid(auth_hash['uid'])
    end

    def create_from_hash(auth_hash)
      User.create(:name => auth_hash['info']['name'],
                  :uid  => auth_hash['uid'])
    end
  end
end