class Product < ActiveRecord::Base
  PER_PAGE = 20

  attr_accessible :body, :price, :title, :pictures_attributes

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 500 }
  validates :price, presence: true

  accepts_nested_attributes_for :pictures, allow_destroy: true

  scope :ordered, -> { order('id DESC') }

  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :reviews, dependent: :destroy

  belongs_to :user
end
