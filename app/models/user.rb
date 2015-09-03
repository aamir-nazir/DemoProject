class User < ActiveRecord::Base

  PRODUCTS_PER_PAGE = 5

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :picture_attributes

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :picture, as: :imageable
  accepts_nested_attributes_for :picture, allow_destroy: true

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: :destroy

  def profile_picture
    self.picture.present? ? self.picture : self.build_picture
  end

  def photo_url
    self.picture.photo.url
  end

  def new_order(cart, total, discount, address)
    self.orders.new(total_items: cart.size, sub_total: total, discount: discount, shipping_address: address)
  end

  def get_products(page)
    self.products.ordered.page(page).per(Product::PER_PAGE)
  end

  def get_reviews(page)
    self.reviews.includes(:product).ordered.page(page).per(Review::PER_PAGE)
  end

end
