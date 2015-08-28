class OrdersController < ApplicationController
  before_filter :set_price, only: [:checkout]
  before_filter :set_cart
  before_filter :set_discount_ratio, only: [:checkout]
  before_filter :authenticate_user!, except: [:checkout]
  before_filter :check_login_status, only: [:checkout]

  def index
    @orders = Order.all

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
end
