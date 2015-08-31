class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if session[:checkout_path] == 1
      session.delete(:checkout_path)
      checkout_orders_path
    elsif resource_class == AdminUser
      admin_dashboard_path
    elsif resource_class == User
      dashboard_users_path
    end
  end

  def cart_encode(cart)
    ActiveSupport::JSON.encode(cart)
  end

  def discounted_price
    @price * (100 - @discount)/100
  end

  def after_update_path_for(resource)
      user_path(resource)
  end

  helper_method :discounted_price
end
