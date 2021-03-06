class OrdersController < ApplicationController
  before_filter :set_price, only: [:checkout, :create]
  before_filter :set_cart
  before_filter :set_discount_ratio, only: [:checkout, :create]
  before_filter :authenticate_user!, except: [:checkout]
  before_filter :check_login_status, only: [:checkout]
  before_filter :set_user, only: [:checkout, :create]
  before_filter :check_customer_address, only: [:create]
  before_filter :authorize_user, only: [:index, :show]
  before_filter :validate_cart, only: [:checkout, :create]

  def index
    @orders = Order.find_orders(params[:user_id])

    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def create
    @sub_total = (session[:discounted] == 1) ? discounted_price : @price
    @order = @user.new_order(@cart, @sub_total, @discount, params[:customer_address])

    response = @order.process_payment(@sub_total, params[:credit_card_no], params[:card_expiry], @user, params[:customer_address])

    if response.success?
      flash[:notice] = "Successfully made a purchase"

      @order.products << Product.find_products(@cart)

      unless @order.save
        flash[:error] = 'Sorry your order has not been sucessfull!'
        redirect_to root_path
      end
      cookies.delete(:cart)
    else
      redirect_to checkout_orders_path, notice: response.response_reason_text
    end
  end

  def checkout
    @products = @cart.present? ? Product.where(id: @cart) : []
  end

  private

    def set_price
      @price = cookies[:cart].present? ? Product.find_products(JSON.parse(cookies[:cart])).sum(:price) : 0
    end

    def set_cart
      @cart = JSON.parse(cookies[:cart]) if (cookies[:cart].present? && JSON.parse(cookies[:cart]).size > 0)
    end

    def set_discount_ratio
      @discount = DiscountCoupon::DISCOUNT
    end

    def check_login_status
      unless user_signed_in?
        session[:checkout_path] = 1
        return redirect_to new_user_session_path, notice: 'Please login to purchase items!'
      end
    end

    def set_user
      @user = User.find(current_user.id) if user_signed_in?
    end

    def check_customer_address
      if params[:customer_address].blank?
        flash[:error] = 'Shipping address must not be empty!'
        return redirect_to checkout_orders_path
      end
    end

    def authorize_user
      unless current_user.id == params[:user_id].to_i
        flash[:error] = 'You are not allowed to view this page!'
        return redirect_to root_path
      end
    end

    def validate_cart
      return redirect_to root_path, alert: 'Please add some items in your cart!' if @cart.blank?
    end
end
