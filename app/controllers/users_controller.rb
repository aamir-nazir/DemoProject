class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  before_filter :set_user

  def show
    @products = @user.products.includes(:pictures).ordered.page(params[:page]).per(User::PRODUCTS_PER_PAGE)
  end

  def dashboard
    @products = current_user.get_products(params[:product_page])
    @reviews = current_user.get_reviews(params[:review_page])
  end

  private
    def set_user
      @user = params[:id].present? ? User.find(params[:id]) : User.find(current_user.id)
    end

end
