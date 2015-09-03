class ReviewsController < ApplicationController
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :validate_user_for_review, only: [:create, :new]
  before_filter :validate_user_for_destroy, only: [:destroy]
  before_filter :validate_user_for_edit, only: [:update, :edit]

  respond_to :html

  def index
    @reviews = Review.product_reviews(params[:product_id])
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
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        format.html { redirect_to product_reviews_path(@product), notice: 'Your review is posted sucessfully!' }
        format.js
      else
        format.html { redirect_to new_product_review_path(@product), flash[:error] = 'Please enter some text for review!' }
        format.js
      end
    end
  end

  def update
    if @review.update_attributes(params[:review])
      flash[:notice] = 'Review updated sucessfully!'
    else
      flash[:error] = 'Review not updated!'
    end
    redirect_to product_reviews_path(@product)
  end

  def destroy
    if @review.destroy
      flash[:notice] = 'Review deleted sucessfully!'
    else
      flash[:notice] = 'Review deletion failed!'
    end
    redirect_to product_path(@product)
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def validate_user_for_review
      if current_user.id == @product.user_id
        flash[:error] = "User cannot review on his own product!"
        return redirect_to product_path(@product)
      end
    end

    def validate_user_for_destroy
      if current_user.id == @review.user_id || current_user.id == @product.user_id
        flash[:notice] = "Review deleted Sucessfully!"
      else
        flash[:error] = "User can only delete his own reviews or only if he/she is Product seller!"
        return redirect_to product_path(@product)
      end
    end

    def validate_user_for_edit
      unless current_user.id == @review.user_id
        flash[:error] = "User can only edit his own reviews!"
        return redirect_to product_path(@product)
      end
    end

end
