class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def logged_in?
      current_user.present?
    end
    helper_method :logged_in?

    def login_required
      redirect_to new_user_path if current_user.blank?
    end

    def current_user=(user)
      session[:auth_user_id] = user.try :id
    end
  
    def current_user
      @current_user ||= User.find session[:auth_user_id] if session[:auth_user_id].present?
    end
    helper_method :current_user

end
