class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]

  def dashboard
    @products = current_user.products.includes(:pictures).ordered.page(params[:product_page]).per(User::PRODUCTS_PER_PAGE)
    @reviews = current_user.reviews.includes(:product).page(params[:review_page]).per(Review::PER_PAGE)
  end

end
