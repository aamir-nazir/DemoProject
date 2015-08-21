class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if resource_class == AdminUser
      admin_dashboard_path
    elsif resource_class == User
      dashboard_users_path
    end
  end

end
