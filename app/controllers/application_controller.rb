class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def signed_in?
    !current_user.nil?
  end

  helper_method :signed_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end
end
