class ProductsController < ApplicationController
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :validate_user, only: [:edit, :update, :destroy]
  before_filter :set_user, only: [:show, :destroy]

  respond_to :html

  def index
    @products =  Product.perform_search({search: params[:search], order: 'created_at DESC', page: params[:page]})
    respond_with(@products)
  end

  def show
    @review = Review.new
    @reviews = @product.reviews
    @product.pictures.build if @product.pictures.blank?
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    if @product.save
      flash[:notice] = 'Product created sucessfully!'
    else
      flash[:error] = 'Product creation failed!'
    end
    respond_with(@product)
  end

  def update
    if @product.update_attributes(params[:product])
      flash[:notice] = 'Your product is updated sucessfully!'
    else
      flash[:error] = 'Product not updated!'
    end
    respond_with(@product)
  end

  def destroy
    if @product.destroy
      flash[:notice] = 'Product deleted sucessfully!'
    else
      flash[:error] = 'Product deletion failed!'
    end
    redirect_to dashboard_users_path(@user)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_user
      @user = @product.user
    end

    def validate_user
      unless current_user.id == @product.user_id
        flash[:error] = 'Not enough Rights!'
        return redirect_to root_path
      end
    end
end
