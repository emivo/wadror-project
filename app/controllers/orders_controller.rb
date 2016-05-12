class OrdersController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_action :set_order, only: [:show, :destroy, :pay, :ensure_own_order, :change_cart]
  before_action :ensure_own_order, only: [:show, :change_cart, :pay, :destroy]
  before_action :ensure_order_has_items, only: [:pay]

  def ensure_own_order
    if !current_user
      unless @order.user_id == session[:anon_id]
        redirect_to :root, alert: 'not your order'
      end
    elsif @order.user_id != current_user.id and !admin
      redirect_to :root, alert: 'not your order'
    end
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.includes(:user)
    unless admin
      if current_user
        @orders = Order.where(user: current_user)
      else
        @orders = Order.where(user_id: session[:anon_id])
      end

    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @products = ProductQuantityInOrder.where(order_id: @order.id).includes(:product)
  end

  # POST /orders
  # POST /orders.json
  def create
    create_cart
    redirect_to current_cart
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if current_cart == @order
      session[:order_id] = nil
    end
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pay
    if current_user
      @order.update_attribute(:paid, true)
      session[:order_id] = nil
      redirect_to @order, notice: 'Order placed'
    else
      redirect_to signin_path, notice: 'You must login first'
    end
  end

  def ensure_order_has_items
    if @order.products.empty?
      redirect_to @order, alert: 'This order is empty!'
    end
  end

  def change_cart
    if current_cart and current_cart.products.empty?
      current_cart.destroy
    end
    session[:order_id] = @order.id
    redirect_to @order, notice: 'This is now your current cart'
  end

  def add_product
    create_cart
    new_item = ProductQuantityInOrder.new params.permit(:quantity)
    new_item.product_id = params[:id]
    quantity = Integer(params[:quantity])
    if quantity > 0
      new_item.order = current_cart
      new_item.save!
      redirect_to product_path(params.permit(:id)), notice: "#{pluralize(quantity, 'Item')} added to cart"
    else
      redirect_to product_path(params.permit(:id)), alert: 'Quantity needs to be positive'
    end
  end

  def remove_product
    product = ProductQuantityInOrder.find(params[:id])
    order = Order.find(product.order_id)
    if order.paid
      redirect_to order, alert: 'Order is already paid. Items cannot remove any more'
    else
      product.destroy
      redirect_to order, notice: 'Item removed from cart'
    end
  end

  def create_cart
    if current_cart.nil?
      if current_user
        new_cart = Order.create user_id: current_user.id
      else
        create_anonym_user
        new_cart = Order.create user_id: session[:anon_id]
      end
      session[:order_id] = new_cart.id
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:user_id)
  end
end
