class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:anon_id]
      if current_cart
        current_cart.update_attribute(:user_id, user.id)
      end
      session[:user_id] = user.id
      cart = Order.find_by(user_id: user.id, paid: false)
      session[:order_id] = cart.id unless cart.nil?
      redirect_to :root, notice: 'Welcome back!'
    else
      redirect_to :back, alert: 'User and password mismatch'
    end
  end

  def destroy

    session[:user_id] = nil
    if current_cart and current_cart.products.empty?
      current_cart.destroy
    end
    session[:order_id] = nil
    session[:anon_id] = nil
    redirect_to :root
  end
end