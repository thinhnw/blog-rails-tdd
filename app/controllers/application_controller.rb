class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authenticate_admin_user!
    redirect_to login_path if session[:admin_user_id].nil?

    @current_admin_user = User.find_by(id: session[:admin_user_id])
  end

  def current_admin_user
    @current_admin_user ||= User.find_by(id: session[:admin_user_id])
  end
end
