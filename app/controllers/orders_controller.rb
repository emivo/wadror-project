class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :paid]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @products = ProductQuantityInOrder.where(order_id: @order.id).includes(:product)
  end

  # GET /orders/new
  def new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    create_cart
    redirect_to current_cart
    # @order = Order.new(order_params)
    #
    # respond_to do |format|
    #   if @order.save
    #     format.html { redirect_to @order, notice: 'Order was successfully created.' }
    #     format.json { render :show, status: :created, location: @order }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
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
# TODO usage
    @order.update_attribute(:paid, true)
  end

  def add_product
    product = Product.find(params[:id])

    create_cart
    # TODO in future possible to add more. Can do with session or params
    ProductQuantityInOrder.create product_id: product.id, order_id: current_cart.id, quantity: 1
    redirect_to product, notice: 'Item added to cart'
  end

  def remove_product
    product = ProductQuantityInOrder.find(params[:id])
    order = Order.find(product.order_id)
    if order.paid
      redirect_to order, notice: 'Order is already paid. Items cannot remove any more'
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
        # todo use the hash or something if not logged in
        new_cart = Order.create
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
