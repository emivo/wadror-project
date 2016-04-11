class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_cart

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end


  def current_cart
    return nil if session[:order_id].nil?
    Order.find(session[:order_id])
  end
end
