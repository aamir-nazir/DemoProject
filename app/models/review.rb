class Review < ActiveRecord::Base
  attr_accessible :body
  belongs_to :product
  belongs_to :user
  PER_PAGE = 5
  scope :ordered, -> { order('id DESC') }
end
