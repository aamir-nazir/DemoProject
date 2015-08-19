class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product, only: [:new, :create, :edit, :update, :destroy]

  respond_to :html

  def index
    @reviews = Review.all
  end

  def show
    respond_with(@review)
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = @product.reviews.new(params[:review])
    @review.save
    respond_to do |format|
      format.html { redirect_to product_reviews_path(@product) }
      format.js
    end
  end

  def update
    @review.update_attributes(params[:review])
    redirect_to product_reviews_path(@product)
  end

  def destroy
    @review.destroy
    redirect_to product_reviews_path(@product)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end
end
