class Review < ActiveRecord::Base
  attr_accessible :body

  validates :body, presence: true, length: { maximum: 500 }

  belongs_to :product
  belongs_to :user
  PER_PAGE = 5
  scope :ordered, -> { order('id DESC') }
  scope :product_reviews, -> (product_id){ where(product_id: product_id) }
end
