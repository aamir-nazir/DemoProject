class Product < ActiveRecord::Base
  attr_accessible :body, :price, :title
  scope :ordered, -> { order('id DESC') }
  PER_PAGE = 20
end
