class ProductsController < ApplicationController
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :validate_user, only: [:edit, :update, :destroy]
  before_filter :set_user, only: [:show]

  respond_to :html

  def index
    @products =  Product.ordered.search(params[:search], page: params[:page], per_page: Product::PER_PAGE)
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
      flash[:notice] = 'Product creation failed!'
    end
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
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
        return redirect_to root_path, notice: "Not enough Rights!"
      end
    end
end
