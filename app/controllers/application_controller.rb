class ApplicationController < ActionController::Base
  protect_from_forgery

  private

    def current_user=(user)
      session[:auth_user_id] = user.id
    end
  
    def current_user
      @current_user ||= User.find session[:auth_user_id] if session[:auth_user_id].present?
    end

end
