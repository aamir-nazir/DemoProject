class Product < ActiveRecord::Base
  attr_accessible :body, :price, :title, :pictures_attributes
  scope :ordered, -> { order('id DESC') }
  PER_PAGE = 20
  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
end
