class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]
  before_filter :set_user

  def show
    @products = @user.products.includes(:pictures).ordered.page(params[:page]).per(User::PRODUCTS_PER_PAGE)
  end

  def dashboard
    @products = current_user.products.includes(:pictures).ordered.page(params[:product_page]).per(User::PRODUCTS_PER_PAGE)
    @reviews = current_user.reviews.includes(:product).page(params[:review_page]).per(Review::PER_PAGE)
  end

  private
    def set_user
      @user = params[:id].present? ? User.find(params[:id]) : User.find(current_user.id)
    end

end
