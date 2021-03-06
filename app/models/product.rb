class Product < ActiveRecord::Base
  PER_PAGE = 12

  attr_accessible :body, :price, :title, :pictures_attributes, :user_id, :delta

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 500 }
  validates :price, presence: true

  scope :ordered, -> { order('id DESC') }
  scope :find_products, ->(id) { where(id: id) }

  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, reject_if: proc { |attributes| attributes['photo'].blank? }, allow_destroy: true
  has_many :reviews, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :orders, through: :order_products

  belongs_to :user

  define_index do
    indexes title
    indexes body
    set_property delta: true

    has :created_at
  end

  def self.perform_search(options = {})
    options[:per_page] = PER_PAGE if options.present?
    self.search options[:search], options
  end

end
