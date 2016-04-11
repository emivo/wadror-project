class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cart = Order.find_by(user_id: user.id, paid: false)
      session[:order_id] = cart.id unless cart.nil?
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to :back, notice: "User and password mismatch"
    end
  end

  def destroy

    session[:user_id] = nil

    redirect_to :root
  end
end