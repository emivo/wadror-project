class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :admin
  helper_method :current_cart
  helper_method :ensure_admin
  helper_method :ensure_logged_in
  helper_method :create_anonym_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end


  def current_cart
    return nil if session[:order_id].nil?
    Order.find(session[:order_id])
  end

  def ensure_logged_in
    if current_user.nil?
      redirect_to :root, alert: 'You need to log in'
    end
  end

  def ensure_admin
    ensure_logged_in
    unless current_user.admin
      redirect_to :root, alert: 'You are not administrator'
    end
  end

  def admin
    return nil if current_user.nil?
    current_user.admin
  end

  def create_anonym_user
    unless current_user
      i = 1000
      serial = rand(10000) + i
      while Order.find_by(user_id: serial) or User.find_by id: serial
        i *= 10
        serial = rand(10000) + i
      end
      session[:anon_id] = serial
    end
  end
end
