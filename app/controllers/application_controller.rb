class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  include Pagy::Backend

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "Please login first"
    end
  end

  def require_admin
    unless current_user&.role == "admin"
      if current_user&.employee_id.present?
        redirect_to employee_path(current_user.employee_id),
                    flash: { alert: "Access denied" }
      else
        redirect_to login_path,
                    flash: { alert: "Access denied" }
      end
      return
    end
  end

  stale_when_importmap_changes
end
