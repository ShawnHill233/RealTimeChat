class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find(session[:user_id])  if session[:user_id].present?
  end

  def login_required
    redirect_to login_url, :alert => "Not authorized" if current_user.nil?
  end

  def admin?
    current_user && current_user.isadmin?
  end

  def admin_required
    unless admin?

      redirect_to root_path, :alert => "You are not authorized for this page."
    end
  end

end
