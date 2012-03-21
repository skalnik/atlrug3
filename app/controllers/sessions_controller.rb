class SessionsController < ApplicationController
  def create
    unless @user = User.find_by_hash(auth_hash)
      @user = User.create_from_hash(auth_hash)
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
