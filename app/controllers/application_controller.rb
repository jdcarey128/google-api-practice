class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def check_logged_in 
    if current_user
      flash[:notice] = 'You are already logged in'
      redirect_to dashboard_path
    end 
  end

  def require_login 
    if !current_user 
      flash[:notice] = 'Please log in'
      redirect_to root_path
    end
  end
end
