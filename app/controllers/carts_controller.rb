class CartsController < ApplicationController
  before_filter :set_product, only: [:remove, :new]
  before_filter :set_price, only: [:index, :validate_coupon]
  before_filter :set_cart
  before_filter :set_discount_ratio
  before_filter :validate_cart, only: [:index]

  def index
    @coupon = DiscountCoupon.new
    @products = @cart.present? ? Product.where(id: @cart) : []
  end

  def new

    if cookies[:cart]
      cart = JSON.parse(cookies[:cart])
      cookies[:cart] = { value: cart_encode(cart.push(params[:product_id]))} unless cart.include?(params[:product_id])
    else
      cookies[:cart] = { value: cart_encode([params[:product_id]]) }
    end

    set_price
    respond_to do |format|
      format.js
    end

  end

  def remove

    if cookies[:cart]
      cart = JSON.parse(cookies[:cart])
      cookies[:cart] = { value: cart_encode(cart - [params[:product_id]])}
    end

    set_price
    respond_to do |format|
      format.js
    end

  end

  def validate_coupon

    @exist = DiscountCoupon.active(params[:discount_coupon][:coupon])
    session[:discounted] = 1 unless @exist.blank?
    respond_to do |format|
      format.js
    end

  end

  private

    def set_product
      @product = Product.find_products(params[:product_id]).first
    end

    def set_price
      @price = cookies[:cart].present? ? Product.find_products(JSON.parse(cookies[:cart])).sum(:price) : 0
    end

    def set_cart
      @cart = (cookies[:cart].present? && JSON.parse(cookies[:cart]).size > 0) ? JSON.parse(cookies[:cart]) : nil
    end

    def set_discount_ratio
      @discount = DiscountCoupon::DISCOUNT
    end

    def validate_cart
      return redirect_to root_path, alert: 'Please add some items in your cart!' if @cart.blank?
    end
end
