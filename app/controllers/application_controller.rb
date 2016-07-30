class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_profile
    @current_profile ||= Profile.find(session[:profile_id]) if session[:profile_id]
  end

  helper_method :current_profile

  def authorize
    redirect_to "/login" unless current_profile
  end
end
